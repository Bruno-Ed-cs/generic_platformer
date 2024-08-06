extends CharacterBody2D

const SPEED : float = 110.0
const JUMP_VELOCITY: float = -240.0

@export var MAX_CAYOTE: float = 0.75
var cayote_timer: float = MAX_CAYOTE:
	set(value):
		cayote_timer = clamp(value, 0, 1.0)

var has_jumped: bool = false

@export var BUFFER_TIME: float = 0.10
var jump_buffer_timer: float:
	set(value):
			jump_buffer_timer = clamp(value, 0, 1.0)


	# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func Jump() -> void:
	velocity.y = JUMP_VELOCITY
	has_jumped = true


func _physics_process(delta):
	# Add the gravity.

	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta


	if not is_on_floor():
		velocity.y += gravity * delta
		cayote_timer -= delta
	else :
		cayote_timer = MAX_CAYOTE
		has_jumped = false


	# Handle jump.
	if Input.is_action_just_pressed("jump") :

		jump_buffer_timer = BUFFER_TIME

		if not has_jumped and cayote_timer > 0:
			Jump()

	if jump_buffer_timer > 0 and is_on_floor():
		Jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
