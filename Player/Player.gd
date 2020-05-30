extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80

var velocity = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# set animation
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
	
	animationState.travel("Run" if input_vector != Vector2.ZERO else "Idle")
	
	# speed = pixel/second, and delta = second/frame, we do this 
	# so we get the relative pixel/frame depending on FPS
	velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)
