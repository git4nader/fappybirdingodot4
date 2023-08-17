extends CanvasLayer


@onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
@onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel
@onready var game_over_menu = $GameOverMenu

func init_game_over_menu(score, highscore): 
	print("game over")
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "BEST: " + str(highscore)
	self.visible = true


func _on_restart_button_pressed():
	print("Restart button pressed")
	get_tree().reload_current_scene()



#func _on_game_over_menu_hidden():
#	pass # Replace with function body.


