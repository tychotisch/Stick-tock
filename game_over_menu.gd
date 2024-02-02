extends Control

@onready var start_level : PackedScene = load("res://Levels/Level1.tscn")

func _ready() -> void:
	connect_signals()

func set_title(value: String) -> void:
	%GameTitle.text = value

func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	Events.emit_signal("reset_game")
	get_tree().change_scene_to_packed(start_level)
	hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func show_game_over() -> void:
	show()
	get_tree().paused = true
	set_title("Game Over")

func connect_signals() -> void:
	Events.connect("game_over", show_game_over)
	%ResetButton.connect("pressed", _on_reset_button_pressed)
	%QuitButton.connect("pressed", _on_quit_button_pressed)
