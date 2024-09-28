extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_labels()


func is_key_held(note):
	# Getter for current key state
	return get_node("Key" + str(note)).bHeld


func set_key_label(note, letter):
	# Sets key label, as long as pressed key is not null
	var key = get_node("Key" + str(note))
	if key.label.text != null:
		key.label.text = letter


func get_key_label(note):
	# Gets key label, as long as pressed key is not null
	var key = get_node("Key" + str(note))
	if key.label.text != null:
		return key.label.text
	else:
		return null


func _on_midi_controller_key_pressed(note: Variant, velocity: Variant) -> void:
	# Get piano key object associated with pitch and press note
	# receives signal from MIDIController node
	var key = get_node("Key" + str(note))
	if (key != null):
		key.key_on()


func _on_midi_controller_key_released(note: Variant) -> void:
	# Get piano key object associated with pitch and unpress note
	# receives signal from MIDIController node
	var key = get_node("Key" + str(note))
	if (key != null):
		key.key_off()


func reset_labels():
	# Ensure all piano key labels are hidden if unused
	for child in self.get_children():
		child.hide_label() # Note: currently tells EVERY child of root to call this function!
