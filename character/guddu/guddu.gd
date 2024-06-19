class_name Guddu
extends CharacterBody2D

signal hit

const InputBitmap = preload("res://utils/input_bitmap.gd")

@export var max_speed := 200
@export var team := Team.PLAYER

@onready var cooldown_timer := $CooldownTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var input_bitmap = InputBitmap.get_input_bitmap()
	var movement_vector = InputBitmap.get_movement_vector(input_bitmap)
	velocity = movement_vector.normalized() * max_speed
	move_and_slide()
	if InputBitmap.is_fire(input_bitmap) and cooldown_timer.get_time_left() <= 0:
		fire_bullet()
		cooldown_timer.start()


func fire_bullet():
	var mouse_position = get_viewport().get_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var bullet = Bullet.create(global_position, direction, team)
	get_tree().get_root().add_child(bullet)


func on_hit():
	hit.emit()
	queue_free()
