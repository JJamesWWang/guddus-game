class_name Clone
extends CharacterBody2D

signal hit

const InputBitmap = preload("res://utils/input_bitmap.gd")

@export var max_speed = 200
@export var team = Team.ENEMY

var index = 0
var recorded_input = []


func _physics_process(_delta):
	if index < self.recorded_input.size():
		var bitmap = self.recorded_input[self.index]
		var movement_vector = InputBitmap.get_movement_vector(bitmap)
		movement_vector = movement_vector.reflect(Vector2.ZERO)
		velocity = movement_vector.normalized() * max_speed
		move_and_slide()
	else:
		index = 0


func on_hit():
	hit.emit()
	queue_free()
