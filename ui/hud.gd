extends Control

signal restart_button_pressed

var game: Game

@onready var score_label = $ScoreLabel
@onready var round_status_label = $RoundStatusLabel
@onready var restart_button = $RestartButton


func _ready():
	game = get_parent()
	if not game is Game:
		push_error("HUD must be a child of Game")
		return
	game.round_starting.connect(_on_round_starting)
	game.round_ended.connect(_on_round_ended)
	game.game_over.connect(_on_game_over)
	game.score_updated.connect(_on_score_updated)


func _on_round_starting(in_seconds: int):
	round_status_label.set_visible(true)
	for i in range(in_seconds):
		round_status_label.set_text("Round starting in %s..." % (in_seconds - i))
		await get_tree().create_timer(1).timeout
	round_status_label.set_visible(false)


func _on_round_ended(for_seconds: int):
	round_status_label.set_visible(true)
	for i in range(for_seconds):
		round_status_label.set_text(
			"Round over! Next round in %s..." % (for_seconds - i)
		)
		await get_tree().create_timer(1).timeout


func _on_game_over():
	round_status_label.set_visible(true)
	round_status_label.set_text("Game over!")
	restart_button.set_visible(true)


func _on_score_updated(score: int):
	score_label.set_text("Score: %s" % score)


func _on_restart_button_pressed():
	game.game_restarting.emit()
	var seconds_until_restart = 3
	for i in range(seconds_until_restart):
		round_status_label.set_text("Restarting in %s..." % (seconds_until_restart - i))
		await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
