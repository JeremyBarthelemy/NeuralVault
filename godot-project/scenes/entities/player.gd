extends CharacterBody2D

@export var speed : float = 300.0
@export var jump_force = -250.0
@export var jump_time : float = 0.25
@export var coyote_time : float = 0.075
@export var gravity_multiplier : float = 3.0


var is_jumping : bool = false
var jump_timer : float = 0
var coyote_timer : float = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
