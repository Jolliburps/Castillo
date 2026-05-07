extends CanvasLayer

signal start_game

func _ready():
	$Message_Label.show()
	$Start_Button.show()

func update_score(value):
	$Score_Label.text = "Score: " + str(value)

func show_message(text):
	$Message_Label.text = text
	$Message_Label.show()
	$Message_Timer.start()

func show_game_over():
	show_message("Game Over")
	await $Message_Timer.timeout
	$Message_Label.text = "Dodge the Creeps!"
	$Message_Label.show()
	await get_tree().create_timer(1.0).timeout
	$Start_Button.show()

func _on_message_timer_timeout():
	$Message_Label.hide()

func _on_start_button_pressed():
	$Start_Button.hide()
	$Message_Label.hide()
	emit_signal("start_game")
