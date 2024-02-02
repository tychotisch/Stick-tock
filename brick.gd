extends StaticBody2D
class_name Brick

@onready var label_pos := $LabelPos
var drop_chance := 0.3
var can_drop := false
var extra_score := false
var score_amount := 20
var brick_health := 1

func _ready() -> void:
	add_to_group("brick")
	powerup_chance()
	extra_score_chance()
	brick_health = %BrickSprite.health

func powerup_chance() -> void:
	randomize()
	can_drop = drop_chance > randf()

func drop_powerup() -> void:
	if can_drop:
		%Powerup.select_powerup()

func extra_score_chance() -> void:
	randomize()
	extra_score = drop_chance > randf()
	if extra_score:
		score_amount *= 2

func take_damage(value) -> void:
	brick_health -= value
	brick_health = clamp(brick_health, 0, brick_health)
	if !brick_health <= 0:
		%HitSound.playing = true
	else:
		drop_powerup()
		delete_brick()

func set_score() -> void:
	Events.emit_signal("set_score", score_amount)
	DamageLabel.set_damage_label(score_amount, label_pos.global_position, extra_score)

func delete_brick() -> void:
	%PickupSound.playing = true
	disable_collision()
	remove_from_group("brick")
	Events.emit_signal("set_brick_removed")
	$Explosion.emitting = true
	await $Explosion.finished
	queue_free()

func _on_detecion_area_body_entered(body: Node2D) -> void:
	if body is Ball:
		if !body.fire_active:
			take_damage(1)
		else:
			take_damage(4)
	%BrickSprite.flash_brick()
	set_score()

func disable_collision() -> void:
	%DetecionArea.set_deferred("collision_layer", false)
	%DetecionArea.set_deferred("collision_mask", false)
