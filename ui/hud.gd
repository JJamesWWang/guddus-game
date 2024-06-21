extends Control

@onready var score_label = $ScoreLabel
@onready var round_status_label = $RoundStatusLabel


func _ready():
	var game: Game = get_parent()
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


func _on_game_over(score: int):
	round_status_label.set_visible(true)
	round_status_label.set_text("Game over! Your final score is %s" % score)


func _on_score_updated(score: int):
	score_label.set_text("Score: %s" % score)
