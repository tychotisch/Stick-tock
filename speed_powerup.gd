extends Area2D

var speed := 200

func _ready() -> void:
	add_to_group("powerup")

func _process(delta: float) -> void:
	position.y += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		Events.emit_signal("increase_speed")
		%PickupSound.playing = true
		await %PickupSound.finished
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
