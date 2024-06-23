class_name Game
extends Node2D

signal round_starting(in_seconds: int)
signal round_ended(for_seconds: int)
signal game_over
signal game_restarting
signal score_updated(score: int)

@export var time_before_round_starts = 2
@export var time_after_round_ends = 1

var guddu = null
var score = 0
var clones_left = 0
var is_over = false

@onready var input_recorder = $InputRecorder
@onready var guddu_spawn_point = $GudduSpawnPoint
@onready var clone_spawn_point = $CloneSpawnPoint


func _ready():
	score_updated.emit(0)
	spawn_guddu()
	start_round()
	game_restarting.connect(_on_restarting)


func spawn_guddu():
	guddu = Guddu.create(guddu_spawn_point.global_position)
	guddu.hit.connect(_on_guddu_hit)
	add_child(guddu)


func start_round():
	if is_over:
		return
	input_recorder.record()
	guddu.set_position(guddu_spawn_point.global_position)
	guddu.movement_enabled = false

	round_starting.emit(time_before_round_starts)
	await get_tree().create_timer(time_before_round_starts).timeout

	spawn_clones()
	guddu.movement_enabled = true
	input_recorder.start()


func spawn_clones():
	clones_left = input_recorder.all_input_history.size()
	for history in input_recorder.all_input_history:
		spawn_clone(history)


func spawn_clone(history):
	var clone = Clone.create(history, clone_spawn_point.global_position)
	clone.hit.connect(_on_clone_hit)
	add_child(clone)


func stop_round():
	if is_over:
		return
	input_recorder.stop()
	round_ended.emit(time_after_round_ends)
	await get_tree().create_timer(time_after_round_ends).timeout
	start_round()


func _on_guddu_hit():
	game_over.emit()
	is_over = true


func _on_clone_hit():
	clones_left -= 1
	score += 1
	score_updated.emit(score)

	if clones_left == 0:
		stop_round()


func _on_restarting():
	clear_clones()


func clear_clones():
	for clone in get_tree().get_nodes_in_group("clone"):
		clone.queue_free()
