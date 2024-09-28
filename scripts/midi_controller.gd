#
#	MIDI input detection:
#
#	Opens MIDI input and sends a signal containing
#	the pitch and velocity of the note pressed.
#

extends Node

@onready var game_manager: Node = %GameManager
@onready var piano_display: Control = $CanvasLayer/PianoDisplay

const MINPITCH:int = 48
const MAXPITCH:int = 72

signal key_pressed(note, velocity)
signal key_released(note)

func _ready():
	# Start listening for midi input
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

func _input(event):
	# Check that the input event is MIDI and within the correct range
	if event is InputEventMIDI:
		if event.channel == 0:
			# If the key being played is within range for the piano display
			if event.pitch >= MINPITCH && event.pitch <= MAXPITCH:
				# Emit signal if key is pressed
				key_pressed.emit(event.pitch, event.velocity)
				if (event.velocity > 0):
					key_pressed.emit(event.pitch, event.velocity)
				elif (event.velocity == 0):
					key_released.emit(event.pitch)


func close_inputs():
	# Stop listening for midi input and free controller
	print("Input is being closed")
	OS.close_midi_inputs()
	queue_free()
