extends KinematicBody2D

const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

var knockback = Vector2.ZERO
var AIR_RESISTANCE = 200

onready var stats = $Stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, AIR_RESISTANCE * delta);
	knockback = move_and_slide(knockback)

func _on_Hurtbox_area_entered(area):
	stats.health -= 1		
		
	knockback = (global_position - area.get_parent().global_position).normalized() * 120
	
func _on_Stats_on_health_equal_zero():
	queue_free()
	
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.position = position
