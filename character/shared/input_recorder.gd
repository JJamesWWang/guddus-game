extends Node

const InputBitmap = preload("res://utils/input_bitmap.gd")

var input_history = PackedByteArray()


func _physics_process(_delta):
	input_history.append(InputBitmap.get_input_bitmap())
