extends Node2D

var is_over = false
var score = 0

@onready var input_recorder = $InputRecorder
@onready var clone_spawn_point = $CloneSpawnPoint


func _ready():
	input_recorder.start()
	spawn_clones()


func _process(_delta):
	if get_tree().get_nodes_in_group("clone").size() == 0:
		spawn_clones()


func spawn_clones():
	input_recorder.record()
	for history in input_recorder.all_input_history:
		spawn_clone(history)


func spawn_clone(history):
	var clone = Clone.create(history, clone_spawn_point.global_position)
	add_child(clone)


func _on_guddu_hit():
	is_over = true
