enum Inputs {
	LEFT = 1,
	RIGHT = 2,
	UP = 4,
	DOWN = 8,
	FIRE = 16,
}


static func get_input_bitmap() -> int:
	var bitmap := 0
	if Input.is_action_pressed("move_left"):
		bitmap |= Inputs.LEFT
	if Input.is_action_pressed("move_right"):
		bitmap |= Inputs.RIGHT
	if Input.is_action_pressed("move_up"):
		bitmap |= Inputs.UP
	if Input.is_action_pressed("move_down"):
		bitmap |= Inputs.DOWN
	if Input.is_action_pressed("fire"):
		bitmap |= Inputs.FIRE
	return bitmap


static func get_movement_vector(bitmap: int) -> Vector2:
	var vector := Vector2()
	if is_left(bitmap):
		vector.x -= 1
	if is_right(bitmap):
		vector.x += 1
	if is_up(bitmap):
		vector.y -= 1
	if is_down(bitmap):
		vector.y += 1
	return vector


static func is_left(input: int) -> bool:
	return (input & Inputs.LEFT) != 0


static func is_right(input: int) -> bool:
	return (input & Inputs.RIGHT) != 0


static func is_up(input: int) -> bool:
	return (input & Inputs.UP) != 0


static func is_down(input: int) -> bool:
	return (input & Inputs.DOWN) != 0


static func is_fire(input: int) -> bool:
	return (input & Inputs.FIRE) != 0
