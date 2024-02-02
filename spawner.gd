extends Node2D


@export_range(1, 10) var rows := 3
@export_range(1, 7) var columns := 7
@export_range(170, 900) var brick_pos_x := 170
@export_range(100, 700) var brick_pos_y := 400
@export var alternate_stack : bool
@export var upside_down_stack : bool
var brick_to_instance := preload("res://Brick/brick.tscn")
var brick_width := 128.0
var brick_height := 64
var playable_width := 1020.0
var brick_spacing := 1.05

func _ready() -> void:

	if !upside_down_stack:
		spawn_normal_bricks()
	else:
		spawn_upside_down_bricks()

func spawn_normal_bricks() -> void:
	for column in range(columns):
		for row in range(rows):
			if !alternate_stack:
				var pos_to_spawn = Vector2(brick_pos_x + (column * brick_width) 
				* brick_spacing,
				brick_pos_y - (row * brick_height) * brick_spacing)
				spawn_brick(pos_to_spawn)
			else:
				var pos_to_spawn = Vector2(brick_pos_x + (column * brick_width) 
				* brick_spacing + (row * brick_width / 2),
				brick_pos_y - (row * brick_height) * brick_spacing)
				spawn_brick(pos_to_spawn)
		if alternate_stack:
			rows -= 1

func spawn_upside_down_bricks() -> void:
	for column in range(columns):
		for row in range(rows):
			if !alternate_stack:
				var pos_to_spawn = Vector2(brick_pos_x + (column * brick_width) 
				* brick_spacing,
				brick_pos_y - (row * brick_height) * brick_spacing)
				spawn_brick(pos_to_spawn)
			else:
				var pos_to_spawn = Vector2(brick_pos_x + (column * brick_width) 
				* brick_spacing + (row * brick_width / 2),
				brick_pos_y + (row * brick_height) * brick_spacing)
				spawn_brick(pos_to_spawn)
		if alternate_stack:
			rows -= 1

func spawn_brick(brick_pos: Vector2) -> void:
	var brick = brick_to_instance.instantiate()
	get_tree().root.add_child.call_deferred(brick)
	brick.global_position = brick_pos


