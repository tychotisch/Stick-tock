extends Node

#list of powerups
var fire_power := preload("res://Powerups/fire_powerup.tscn")
var speed_power := preload("res://Powerups/speed_powerup.tscn")

var powers_list := [fire_power, speed_power]

func _ready() -> void:
	randomize()

func select_powerup() -> void:
		var powerup_to_instance = powers_list[randi() % powers_list.size()]
		var powerup = powerup_to_instance.instantiate()
		get_tree().root.call_deferred("add_child", powerup)
		powerup.global_position = %LabelPos.global_position
