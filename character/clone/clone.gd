class_name Clone
extends CharacterBody2D

signal hit

const InputBitmap = preload("res://utils/input_bitmap.gd")
const CloneScene = preload("res://character/clone/clone.tscn")

@export var max_speed = 900

var team = Team.ENEMY

var input_index = 0
var index_direction = 1
var recorded_input = []

var recorded_fire_coordinates = []
var fire_index = 0

@onready var cooldown_timer = $CooldownTimer


static func create(history, in_position):
	var clone = CloneScene.instantiate()
	clone.recorded_input = history["input"]
	clone.recorded_fire_coordinates = history["fire_coordinates"]
	clone.position = in_position
	return clone


func _ready():
	cooldown_timer.stop()


func _physics_process(_delta):
	if recorded_input.size() == 0:
		return

	if input_index < recorded_input.size() and input_index >= 0:
		var bitmap = recorded_input[input_index]
		var movement_vector = InputBitmap.get_movement_vector(bitmap)

		movement_vector.x *= -1 * index_direction
		movement_vector.y *= -1 * index_direction

		velocity = movement_vector.normalized() * max_speed
		move_and_slide()

		if InputBitmap.is_fire(bitmap):
			fire_bullet()
	else:
		if index_direction == 1:  # finished full path, shoot at player's last known position
			fire_mirrored_bullet()
		index_direction *= -1
	input_index += 1 * index_direction


func fire_bullet():
	if recorded_fire_coordinates.size() == 0:
		return

	if (
		fire_index < recorded_fire_coordinates.size()
		and fire_index >= 0
		and cooldown_timer.is_stopped()
	):
		var fire_location = mirror_location(recorded_fire_coordinates[fire_index])
		var fire_direction = (fire_location - global_position).normalized()
		var bullet = Bullet.create(global_position, fire_direction, team)
		get_tree().get_root().add_child(bullet)
		cooldown_timer.start()
	fire_index += 1 * index_direction


func mirror_location(location):
	return Vector2(980 - (location.x - 980), 540 - (location.y - 540))


# note: no cooldown
func fire_mirrored_bullet():
	var fire_location = mirror_location(global_position)
	var fire_direction = (fire_location - global_position).normalized()
	var bullet = Bullet.create(global_position, fire_direction, team)
	get_tree().get_root().add_child(bullet)


func on_hit():
	hit.emit()
	queue_free()
