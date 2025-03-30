extends CharacterBody2D

signal OnUpdateHealth(health : int)
signal OnUpdateScore(score : int)


@export var move_speed : float = 100.0
@export var acceleration : float = 50.0
@export var braking : float = 20.0
@export var gravity : float = 500.0
@export var jump_force : float = 200.0
@export var health : int = 3

var move_input : float

# onready means when the object is initialized
# We could do this in the _on_ready function but this is nice too to shrink
# down code a bit if we wish to
@onready var sprite : Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

var take_damage_sfx : AudioStream = preload("res://Audio/take_damage.wav")
var coin_sfx : AudioStream = preload("res://Audio/coin.wav")

# For physics engine changes, use _physics_process(delta)
func _physics_process(delta):
	# Documentation says it's best to only apply gravity when not standing because
	# it can lead to some bugs (strangely) when applying gravity on ground?
	if not is_on_floor():
		velocity.y += gravity * delta

   # Move input is basically -1 for left and +1 for right (a direction)
	move_input = Input.get_axis("move_left", "move_right")

	# if pressing, accelerate, else braking?
	# If we are pressing left or right
	if move_input != 0: # Accelerate!
		# lerp() linear interpolation from current velocity to direction * move speed
		# with weight of acceleration over delta
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else: # Apply the brakes!
		# lerp() linear interpolation from current velocity to a stop (0)
		# with weight of braking over delta
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	# Jumping
	# Only jump if jump button is pressed and we are on the floor
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	# Takes the current velocity, applies it to current info, handles
	# any collision detection, etc. In other words, always call this
	# AFTER changing Character2DBody's velocity to properly update.
	move_and_slide()

# Perform tasks which aren't really involved with the physics engine
func _process(delta):
	if velocity.x != 0:	
		sprite.flip_h = velocity.x > 0
	
	if global_position.y > 200:
		game_over()
	_manage_animation()

func _manage_animation():
	if not is_on_floor():
		anim.play("jump")
	elif move_input != 0:
		anim.play("move")
	else:
		anim.play("idle")

func take_damage(amount : int):
	health -= amount
	OnUpdateHealth.emit(health)
	_damage_flash()
	play_sound(take_damage_sfx)
		
	if health <= 0:
		call_deferred("game_over")

func game_over():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")	

func increase_score(amount : int):
	# Here we are keeping scores persistent across scenes
	PlayerStats.score += amount
	OnUpdateScore.emit(PlayerStats.score)
	play_sound(coin_sfx)

func _damage_flash():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	sprite.modulate = Color.WHITE

func play_sound(sound : AudioStream):
	audio.stream = sound
	audio.play()
