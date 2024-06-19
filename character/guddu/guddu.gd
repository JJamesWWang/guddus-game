extends CharacterBody2D

const InputBitmap = preload("res://utils/input_bitmap.gd")

@export var max_speed = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var input_bitmap = InputBitmap.get_input_bitmap()
	var movement_vector = InputBitmap.get_movement_vector(input_bitmap)
	velocity = movement_vector.normalized() * max_speed
	move_and_slide()
