class_name Game
extends Node2D

signal round_starting(in_seconds: int)
signal round_ended(for_seconds: int)
signal game_over
signal score_updated(score: int)

@export var time_before_round_starts = 3
@export var time_after_round_ends = 2

var guddu = null
var score = 0

@onready var input_recorder = $InputRecorder
@onready var guddu_spawn_point = $GudduSpawnPoint
@onready var clone_spawn_point = $CloneSpawnPoint


func _ready():
	score_updated.emit(0)
	spawn_guddu()
	start_round()


func spawn_guddu():
	guddu = Guddu.create(guddu_spawn_point.global_position)
	guddu.hit.connect(_on_guddu_hit)
	add_child(guddu)


func start_round():
	input_recorder.record()
	guddu.set_position(guddu_spawn_point.global_position)
	round_starting.emit(time_before_round_starts)
	await get_tree().create_timer(time_before_round_starts).timeout
	spawn_clones()
	input_recorder.start()


func spawn_clones():
	for history in input_recorder.all_input_history:
		spawn_clone(history)


func spawn_clone(history):
	var clone = Clone.create(history, clone_spawn_point.global_position)
	clone.hit.connect(_on_clone_hit)
	add_child(clone)


func stop_round():
	input_recorder.stop()
	round_ended.emit(time_after_round_ends)
	await get_tree().create_timer(time_after_round_ends).timeout
	start_round()


func _on_guddu_hit():
	game_over.emit(score)


func _on_clone_hit():
	score += 1
	score_updated.emit(score)
	if get_tree().get_nodes_in_group("clone").size() <= 1:
		stop_round()
