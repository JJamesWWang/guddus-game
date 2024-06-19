extends Node

const InputBitmap = preload("res://utils/input_bitmap.gd")

var all_input_history = Array()
var input_history = PackedByteArray()
var fire_coordinates = PackedVector2Array()
var is_active = false


func start():
	is_active = true


func stop():
	is_active = false


func record():
	var history = {
		"input": input_history,
		"fire_coordinates": fire_coordinates,
	}
	all_input_history.append(history)
	input_history = PackedByteArray()
	fire_coordinates = PackedVector2Array()


func _physics_process(_delta):
	if is_active:
		var bitmap = InputBitmap.get_input_bitmap()
		input_history.append(bitmap)
		if InputBitmap.is_fire(bitmap):
			fire_coordinates.append(get_viewport().get_mouse_position())
