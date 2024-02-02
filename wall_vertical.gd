extends StaticBody2D


func _ready() -> void:
	Events.connect("ball_exited_screen", flash_walls)

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		%Hitflash.play("flash")
		%AudioStreamPlayer.playing = true

func flash_walls(_value) -> void:
	%Hitflash.play("flash")
