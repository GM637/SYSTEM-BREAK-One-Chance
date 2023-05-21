extends Area2D

func _ready():
	
	connect("body_entered",self , "entered")

func entered(body):
	if body.has_method("is_player") :
		get_tree().current_scene.stamp(name)
		queue_free()
