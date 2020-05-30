extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# speed = pixel/second, and delta = second/frame, we do this 
	# so we get the relative pixel/frame depending on FPS
	velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)
