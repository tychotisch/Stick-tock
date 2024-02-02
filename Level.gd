extends Node2D

@export var next_level : PackedScene

func _ready() -> void:
	Events.connect("set_brick_removed", set_bricks)
	Events.connect("reset_game", reset_level)

func set_bricks() -> void:
	var bricks_in_game = get_tree().get_nodes_in_group("brick")
	if !bricks_in_game:
		go_to_next_level()

func clear_powers() -> void:
	var powerup = get_tree().get_nodes_in_group("powerup")
	for power in powerup:
		power.queue_free()

func clear_balls() -> void:
	var balls = get_tree().get_nodes_in_group("ball")
	for ball in balls:
		ball.queue_free()

func clear_bricks() -> void:
	var bricks = get_tree().get_nodes_in_group("brick")
	for brick in bricks:
		brick.queue_free()

func go_to_next_level() -> void:
	clear_powers()
	clear_balls()
	clear_bricks()
	if !next_level:
		$GameOverMenu.show_game_over()
		$GameOverMenu.set_title("You've Won")
	else:
		%SceneTransition.play("fade_in")
		await %SceneTransition.animation_finished
		get_tree().change_scene_to_packed(next_level)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		clear_powers()
		clear_balls()
		clear_bricks()
		go_to_next_level()

func reset_level() -> void:
	clear_balls()
	clear_bricks()
	clear_powers()
	GlobalVar.reset_variables()

