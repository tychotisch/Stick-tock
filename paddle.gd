extends CharacterBody2D
class_name Paddle

var speed = 700.0
var can_spawn_ball = true
var pos_y

func _ready() -> void:
	add_to_group("paddle")
	Events.connect("reset_ball", reset_ball)
	pos_y = position.y

func _physics_process(_delta: float) -> void:
	#set_keyboard_movement()
	set_mouse_movement()
	move_and_slide()
	if position.y > pos_y:
		position.y = pos_y
	if position.y < pos_y:
		position.y = pos_y

func set_mouse_movement() -> void:
	var direction : Vector2 = (get_global_mouse_position() - global_position)
	velocity.x = direction.x * speed / 20

#func set_keyboard_movement() -> void:
	#var direction := Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and can_spawn_ball:
		spawn_ball()
		can_spawn_ball = false
		%BallSprite.hide()

func spawn_ball() -> void:
	var ball_to_instance = preload("res://Ball/ball.tscn")
	var ball = ball_to_instance.instantiate()
	get_tree().root.add_child(ball)
	ball.global_position = %BallSpawnPos.global_position
	ball.start_ball()

func reset_ball() -> void:
		can_spawn_ball = true
		%BallSprite.show()
