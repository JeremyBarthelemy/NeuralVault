extends Control



## Called when the node enters the scene tree for the first time.
func _ready():
	# Connect button signals
	$VBoxContainer/CoinChaseButton.connect("pressed", _on_coin_chase_pressed)
	$VBoxContainer/PlayButton.connect("pressed", _on_play_pressed)
	$VBoxContainer/SettingsButton.connect("pressed", _on_settings_pressed)
	$VBoxContainer/CreditsButton.connect("pressed", _on_credits_pressed)
	$VBoxContainer/QuitButton.connect("pressed", _on_quit_pressed)

func _on_coin_chase_pressed():
	print("Play Coin Chase demo!")
	get_tree().change_scene_to_file("res://scenes/entities/main.tscn") # todo JLB - reorganize these as needed

func _on_play_pressed():
	print("Play game")
	#get_tree().change_scene_to_file("res://Game.tscn")  # Replace with game scene
	get_tree().change_scene_to_file("res://scenes/main.tscn")  # Replace with game scene

func _on_settings_pressed():
	print("Open Settings Menu")  # Replace with settings logic

func _on_credits_pressed():
	print("Pressed Credits Button!") # Replace this with credits logic

func _on_quit_pressed():
	get_tree().quit()
