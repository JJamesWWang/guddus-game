extends CharacterBody2D

const InputBitmap = preload("res://utils/input_bitmap.gd")

@export var max_speed = 200
@export var team = Team.ENEMY


func _init(recorded_input: PackedByteArray):
	self.recorded_input = recorded_input
	self.index = 0


func _physics_process(_delta):
	if self.index < self.recorded_input.size():
		var bitmap = self.recorded_input[self.index]
		var movement_vector = InputBitmap.get_movement_vector(bitmap)
		movement_vector = movement_vector.reflect(Vector2.ZERO)
		velocity = movement_vector.normalized() * max_speed
		move_and_slide()
	else:
		self.index = 0
