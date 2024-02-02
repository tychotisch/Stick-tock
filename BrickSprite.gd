extends Sprite2D

var brick_0 := preload("res://Assets/bricks/brick0.png")
var brick_1 := preload("res://Assets/bricks/brick1.png")
var brick_2 := preload("res://Assets/bricks/brick2.png")
var brick_4 := preload("res://Assets/bricks/brick4.png")
var brick_5 := preload("res://Assets/bricks/brick5.png")
var brick_sprites := [brick_0, brick_1, brick_2, brick_4]
var brick_colors := {brick_0 : "#00EAD3", brick_1 : "#FFF5B7", 
brick_2 : "#FF449F", brick_4 : "#FFFFFF"}
var brick_health := {brick_0 : 1, brick_1 : 3, brick_2 : 2, brick_4 : 1}
var health := 1
var brick

func _ready() -> void:
	randomize()
	set_brick_sprite()
	set_explosion_color()
	set_brick_health()

func set_brick_sprite() -> void:
	brick = brick_sprites[randi() % brick_sprites.size()]
	texture = brick

func set_explosion_color() -> void:
	var explosion_color
	if brick == brick_0:
		explosion_color = brick_colors[brick_0]
	if brick == brick_1:
		explosion_color = brick_colors[brick_1]
	if brick == brick_2:
		explosion_color = brick_colors[brick_2]
	if brick == brick_4:
		explosion_color = brick_colors[brick_4]
	%Explosion.set_explosion_color(explosion_color)

func set_brick_health() -> void:
	if brick == brick_0:
		health = brick_health[brick_0]
	if brick == brick_1:
		health = brick_health[brick_1]
	if brick == brick_2:
		health = brick_health[brick_2]
	if brick == brick_4:
		health = brick_health[brick_4]

func flash_brick() -> void:
	%AnimationPlayer.play("brick_flash")
