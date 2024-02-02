extends CharacterBody2D
class_name Ball

@export_range(400, 1100) var max_speed = 970
const BRICK_MASK := 3
var speed_multiplier = 1.01
var speed = 400
var ball_speed = speed
var direction = Vector2(0.5, -1)
var object_collision 
var player
var fire_active := false
var timer = Timer.new()

func _ready() -> void:
	add_to_group("ball")
	Events.connect("start_fireball", activate_fireball)
	Events.connect("increase_speed", set_speed_max)
	Events.connect("shaken", randomize_direction)
	timer.connect("timeout", _on_timer_timeout)
	get_tree().root.add_child(timer)

func _physics_process(delta: float) -> void:
	direction = direction.normalized()
	velocity = ball_speed * direction * delta
	var collision = move_and_collide(velocity)
	if collision:
		direction = direction.bounce(collision.get_normal())
		increase_speed()

		if collision.get_collider() is Paddle:
			player = collision.get_collider()
			on_paddle_collision()
			increase_speed()
			%HitSound.playing = true

func on_paddle_collision() -> void:
	var distance = player.global_position.x - global_position.x
	var width = 130
	var angle = clamp(distance / width, -2, 2)
	direction.x = angle * -1

func increase_speed() -> void:
	speed = speed * speed_multiplier
	ball_speed = speed
	ball_speed = clamp(ball_speed, 400, max_speed)

func start_ball() -> void:
	randomize()
	velocity.x = [-1, 1][randi() % 2] * speed
	velocity.y = [-1, 1][randi() % 2] * speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	remove_from_group("ball")
	Events.emit_signal("ball_exited_screen", -1)
	queue_free()

func activate_fireball() -> void:
	$AnimationPlayer.play("fireball")
	%FireParticles/CPUParticles2D.emitting = true
	set_collision_mask_value(BRICK_MASK, false)
	fire_active = true
	timer.start(6)

func deactivate_power() -> void:
	$AnimationPlayer.play("RESET")
	%FireParticles/CPUParticles2D.emitting = false
	set_collision_mask_value(BRICK_MASK, true)
	fire_active = false

func _on_timer_timeout() -> void:
	if !fire_active:
		return
	else:
		deactivate_power()

func randomize_direction() -> void:
	direction.y = [-1, 1][randi() % 2]
	direction.x = [-1, 1][randi() % 2]

func set_speed_max() -> void:
	speed = max_speed
	ball_speed = max_speed

