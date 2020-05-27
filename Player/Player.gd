extends KinematicBody2D

const ACCELERATION = 10
const MAX_SPEED = 100

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED * delta, ACCELERATION * delta)
	
	move_and_collide(velocity)
