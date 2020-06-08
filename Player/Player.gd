extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const ROLL_SPEED_FACTOR = 1.2

enum {
	MOVE,
	ATTACK,
	ROLL
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
			if Input.is_action_just_pressed("ui_attack"):
				state = ATTACK
				
			if Input.is_action_just_pressed("ui_roll"):
				state = ROLL
		ATTACK:
			attack_state(delta)
		ROLL:
			roll_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# set animation
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
	
	animationState.travel("Run" if input_vector != Vector2.ZERO else "Idle")
	
	# speed = pixel/second, and delta = second/frame, we do this 
	# so we get the relative pixel/frame depending on FPS
	velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION * delta)
	
	move()
	
func roll_state(delta):
	velocity = roll_vector * MAX_SPEED * ROLL_SPEED_FACTOR
	animationState.travel("Roll")
	move()

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity)

func on_roll_animation_end():
	state = MOVE
	
func on_attack_animation_end():
	state = MOVE
