extends Node2D

@onready var sprite = $Sprite2D


func _input(event):
	if event is InputEventMouseMotion:
		var sprite_position = sprite.get_global_position()
		var mouse_position = event.position
		sprite.rotation = (mouse_position - sprite_position).angle()
		if abs(sprite.rotation) < PI / 2:
			sprite.flip_v = false
		else:
			sprite.flip_v = true
