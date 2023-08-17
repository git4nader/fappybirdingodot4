extends Node2D

signal score

@onready var point = $Point

const SPEED = 215


func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free() 
		#print("bye")


func _on_wall_body_entered(body):
		if body is Player: 
			#print("player hit wall")
			if body.has_method("die"):
				body.die()


func _on_score_area_body_exited(body):	
	if body is Player:
		#print("Player Scored")
		point.play()
		emit_signal("score")
