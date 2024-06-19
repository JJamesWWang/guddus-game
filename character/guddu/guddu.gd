extends CharacterBody2D

const InputBitmap = preload("res://utils/input_bitmap.gd")

@export var max_speed = 200
@export var team = Team.PLAYER


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var input_bitmap = InputBitmap.get_input_bitmap()
	var movement_vector = InputBitmap.get_movement_vector(input_bitmap)
	velocity = movement_vector.normalized() * max_speed
	move_and_slide()
	if InputBitmap.is_fire(input_bitmap):
		fire_bullet()


func fire_bullet():
	var mouse_position = get_viewport().get_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var bullet = Bullet.create(global_position, direction, team)
	get_tree().get_root().add_child(bullet)
