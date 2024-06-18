extends CharacterBody2D

@export var max_speed = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		input_vector += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		input_vector += Vector2(1, 0)
	if Input.is_action_pressed("move_up"):
		input_vector += Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		input_vector += Vector2(0, 1)

	velocity = input_vector.normalized() * max_speed
	move_and_slide()
