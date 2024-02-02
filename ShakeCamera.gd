extends Camera2D

var random_strength := 30.0
var strength := 0.0
var fade := 5.0
var random_number = RandomNumberGenerator.new()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shake") and GlobalVar.shakes > 0:
		shake_table()
		Events.emit_signal("shaken")

	if strength > 0.0:
		strength = lerp(strength, 0.0, fade * delta)
		offset = random_offset()

func shake_table() -> void:
	strength = random_strength

func random_offset() -> Vector2:
	return (Vector2(random_number.randf_range(-strength, strength),
	random_number.randf_range(-strength, strength)))
