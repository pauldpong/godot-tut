extends Node

export var max_health = 1
onready var health = max_health setget set_health

signal on_health_equal_zero

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("on_health_equal_zero")
