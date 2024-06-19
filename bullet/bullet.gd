class_name Bullet
extends CharacterBody2D

const PlayerBulletScene = preload("res://bullet/player_bullet.tscn")
const CloneBulletScene = preload("res://bullet/clone_bullet.tscn")

@export var speed := 400

var team: int

@onready var sprite := $Sprite2D


static func create(in_position: Vector2, direction: Vector2, in_team: int):
	var bullet: Bullet
	if in_team == Team.PLAYER:
		bullet = PlayerBulletScene.instantiate()
	elif in_team == Team.ENEMY:
		bullet = CloneBulletScene.instantiate()
	else:
		print("Invalid team")
		return null

	bullet.position = in_position
	bullet.velocity = direction * bullet.speed
	return bullet


func _physics_process(delta):
	move_and_collide(velocity * delta)
