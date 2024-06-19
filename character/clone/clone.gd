class_name Clone
extends CharacterBody2D

signal hit(recorded_input)

const InputBitmap = preload("res://utils/input_bitmap.gd")
const CloneScene = preload("res://character/clone/clone.tscn")

@export var max_speed = 200

var team = Team.ENEMY
var index = 0
var recorded_input = []
var index_direction = 1


static func create(in_input, in_position):
	var clone = CloneScene.instantiate()
	clone.position = in_position
	clone.recorded_input = in_input
	return clone


func _physics_process(_delta):
	if recorded_input.size() == 0:
		return

	if index < recorded_input.size() and index >= 0:
		var bitmap = recorded_input[index]
		var movement_vector = InputBitmap.get_movement_vector(bitmap)

		movement_vector = movement_vector.reflect(Vector2(0, 1))
		if index_direction == -1:
			movement_vector = movement_vector.reflect(Vector2(1, 0))

		velocity = movement_vector.normalized() * max_speed
		move_and_slide()
	else:
		index_direction *= -1
	index += 1 * index_direction


func fire_bullet():
	pass


func on_hit():
	hit.emit(recorded_input)
	queue_free()
