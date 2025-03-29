extends Area2D

var rotate_speed : float = 3.0
var bob_height : float = 5.0
var bob_speed : float = 5.0

@onready var start_pos : Vector2 = global_position

@onready var sprite : Sprite2D =  $Sprite

func _physics_process(delta):
	
	# Need current time to make sine wave for rotating the coin!
	var time = Time.get_unix_time_from_system()
	
	# rotate
	sprite.scale.x = sin(time * rotate_speed)
	
	# bob up and down
	var y_pos = bob_height * (1 + sin(time * bob_speed))/2
	global_position.y = start_pos.y - y_pos
	
	
	
	
