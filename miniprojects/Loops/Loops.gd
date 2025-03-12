extends Node2D

@export var spawn_count : int = 200
var star_scene = preload("res://Loops/Star.tscn")

func _ready():
	for i in spawn_count:
		var star = star_scene.instantiate()
		# Must add star to scene tree or it just sits in memory. This script
		# is associated with our root node, so star will be a child of "Main"
		add_child(star)
		star.position.x = randi_range(-280, 280)
		star.position.y = randi_range(-150, 150)
		
		var star_size = randf_range(0.5, 1.0)
		star.scale.x = star_size
		star.scale.y = star_size
