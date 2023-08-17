extends Node2D

signal died

@onready var hud = $HUD
@onready var obstacle_spawner = $ObstacleSpawner
@onready var ground = $Ground
@onready var game_over_layer = $GameOverLayer
@onready var start_menu_layer = $StartMenuLayer

#where use://savedata.save is saved? in file manager adderee type: %appdata% >>>
#C:\Users\nfarr\AppData\Roaming >>> C:\Users\nfarr\AppData\Roaming\Godot >>>
#C:\Users\nfarr\AppData\Roaming\Godot\app_userdata >>> 
#C:\Users\nfarr\AppData\Roaming\Godot\app_userdata\Flappy Bird 4

#const SAVE_FILE_PATH = "user://savedata.save"

var score = 0
var highscore = 0
var save_data_res = "user://savedata.txt"

func _ready():
	#	new_game()
	obstacle_spawner.connect("obstacle_created", _on_obstacle_created)
	#save_highscore()
	load_highscore()
#	

func new_game():
	self.score = 0
	obstacle_spawner.start()

func player_score(): 
	self.score += 1
	set_score(score)
	#print(score)

func get_score():
	return score
	
func set_score(new_score):
	score = new_score
	hud.update_score(score)
	
func _on_obstacle_created(obs):
	obs.connect("score", player_score)


func _on_deathzone_body_entered(body):
	if body is Player:
		#print("player hit ground")
		if body.has_method("die"):
			body.die()

func _on_player_died():
	game_over()


func game_over():
	obstacle_spawner.stop()
#	_set_animation_player(AnimationPlayer)
	ground.get_node("%AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	game_over_layer.init_game_over_menu(score, highscore)
	
		
func _on_menu_layer_start_game():
	new_game()
	
	
func save_highscore():
	#var ave_data_res = FileAccess.new()
	#var save_data_res = "user://savedata.txt"
	var savedata = FileAccess.open( save_data_res, FileAccess.WRITE)
	savedata.store_string("%s" % highscore)
	#save_data_res.close()
	
func load_highscore():
	#var save_data_res = "user://savedata.txt"
	var loaddata = FileAccess.open(save_data_res, FileAccess.READ)
	highscore = loaddata.get_as_text(true).to_int()
	
	
#	if  loaddata.file_exists(save_data_res):
#		var highscore = loaddata.get_var()
#	print_debug(highscore)
#	#save_data_res.close()
#
	

