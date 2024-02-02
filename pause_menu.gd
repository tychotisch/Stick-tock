extends Control


func _ready() -> void:
	connect_signals()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		show()
		%ResetButton.hide()
		get_tree().paused = true

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	Events.emit_signal("reset_game")
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func connect_signals() -> void:
	%StartButton.connect("pressed", _on_start_button_pressed)
	%ResetButton.connect("pressed", _on_reset_button_pressed)
	%QuitButton.connect("pressed", _on_quit_button_pressed)
