extends Node

const InputBitmap = preload("res://utils/input_bitmap.gd")

var all_input_history = Array()
var input_history = PackedByteArray()
var is_active = false


func start():
	is_active = true


func stop():
	is_active = false


func record():
	var history_copy = PackedByteArray(input_history)
	all_input_history.append(history_copy)
	return history_copy
	# input_history = PackedByteArray()


func _physics_process(_delta):
	if is_active:
		input_history.append(InputBitmap.get_input_bitmap())
