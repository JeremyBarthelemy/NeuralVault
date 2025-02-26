extends CanvasLayer

signal start_game

func update_score(value):
	$MarginContainer/Score.text = str(value)

func update_time(value):
	$MarginContainer/Time.text = str(value)

func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()

func on_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	print("Start button pressed!")
	$StartButton.hide()
	$Message.hide()
	start_game.emit()

func show_game_over():
	show_message("Game Over")
	await $Timer.timeout
	$StartButton.show()
	$Message.text = "Coin Dash!"
	$Message.show()

func _ready():
	# Connect button signals
	$StartButton.connect("pressed", _on_start_button_pressed)
