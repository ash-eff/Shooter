extends CanvasLayer

signal play_complete
signal rewind_complete

onready var run_timer = $RunTimer
onready var cooldown_timer = $CooldownTimer
onready var ability_bar = $PlayerGUIControl/AbilityBar
var icons = []
var selected_icon = null
var rewinding_icon = null
export var current_icon_index = 0
var is_playing = false
var is_rewinding = false

func _ready() -> void:
	set_process(false)
	connect("play_complete", get_parent().get_node("VCR"), "_on_tape_play_complete")
	connect("rewind_complete", get_parent().get_node("VCR"), "_on_tape_rewind_complete")

func _process(delta):
	if selected_icon == null:
		return;
	if selected_icon.cooldown == 0:
		return
	if is_playing:
		selected_icon.sweep.set_fill_mode(5)
		selected_icon.sweep.value = int((run_timer.time_left / selected_icon.run) * 100)
	if is_rewinding:
		selected_icon.sweep.set_fill_mode(4)
		selected_icon.sweep.value = int((cooldown_timer.time_left / selected_icon.cooldown) * 100)

func add_ability_icon(tape):
	var i = tape.vhs_tape.Icon.instance()
	icons.append(i)
	ability_bar.add_child(i)
	if icons.size() == 1:
		i.select_item()

func _on_VCR_tape_aquired(tape) -> void:
	add_ability_icon(tape)

func _on_VCR_swap_tapes(index) -> void:
	if current_icon_index == index:
		return
	icons[current_icon_index].deselect_item()
	selected_icon = icons[index]
	selected_icon.select_item()
	current_icon_index = index

func _on_VCR_play_tape() -> void:
	if selected_icon == null:
		return
	is_playing = true
	run_timer.set_wait_time(selected_icon.run)
	cooldown_timer.set_wait_time(selected_icon.cooldown)
	selected_icon.activate()
	set_process(true)
	run_timer.start()

func _on_RunTimer_timeout() -> void:
	rewinding_icon = selected_icon
	rewinding_icon.outline.rewind()
	cooldown_timer.start()
	emit_signal("play_complete")

func _on_CooldownTimer_timeout() -> void:
	rewinding_icon.key_label.show()
	rewinding_icon.sweep.value = 0
	rewinding_icon.outline.visible = false
	emit_signal("rewind_complete")
	set_process(false)	
