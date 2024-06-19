class_name Team
extends Node

enum { NEUTRAL, PLAYER, ENEMY }

@export var team := NEUTRAL


static func to_collision_layer(in_team: int) -> int:
	match in_team:
		PLAYER:
			return 2
		ENEMY:
			return 3
		_:
			return 1  # wall


static func opposing(in_team: int) -> int:
	match in_team:
		PLAYER:
			return ENEMY
		ENEMY:
			return PLAYER
		_:
			return NEUTRAL
