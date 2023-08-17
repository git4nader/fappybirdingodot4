extends CanvasLayer

signal start_game

#@onready var start_message = $StartMenu/StartMessage
#@onready var tween = $Tween

#@onready var start_menu = $StartMenu

var game_started = false

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		self.visible = false
		emit_signal("start_game")
		game_started = true


