extends Node2D

var is_over = false
var score = 0

@onready var input_recorder = $InputRecorder
@onready var clone_spawn_point = $CloneSpawnPoint


func _ready():
	input_recorder.start()
	spawn_clone()


func _process(_delta):
	pass


func spawn_clone():
	var recorded_input = input_recorder.record()
	var clone = Clone.create(recorded_input, clone_spawn_point.global_position)
	clone.hit.connect(_on_clone_hit)
	add_child(clone)


func _on_guddu_hit():
	is_over = true


func _on_guddu_fired():
	pass


func _on_clone_hit(recorded_input):
	var input_copy = PackedByteArray(recorded_input)
	spawn_clone()
	await get_tree().create_timer(3).timeout
	# respawn_clone(input_copy)


func respawn_clone(recorded_input):
	var clone = Clone.create(recorded_input, clone_spawn_point.global_position)
	clone.hit.connect(_on_clone_hit)
	add_child(clone)
