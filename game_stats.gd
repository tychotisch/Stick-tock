extends Control


func _ready() -> void:
	Events.connect("ball_exited_screen", set_lives)
	Events.connect("set_score", set_score)
	Events.connect("shaken", set_shakes)
	%ScoreAmountLabel.text = str(GlobalVar.score)
	%LivesAmountLabel.text = str(GlobalVar.lives)
	%ShakeAmountLabel.text = str(GlobalVar.shakes)

func set_score(value) -> void:
	GlobalVar.score += value
	%ScoreAmountLabel.text = str(GlobalVar.score)

func set_lives(value) -> void:
	GlobalVar.lives += value
	%LivesAmountLabel.text = str(GlobalVar.lives)
	if !GlobalVar.lives:
		Events.emit_signal("game_over")
	else:
		Events.emit_signal("reset_ball")

func set_shakes() -> void:
	GlobalVar.shakes -= 1
	%ShakeAmountLabel.text = str(GlobalVar.shakes)
