extends Light2D

var get = 0
var to = 0

func _ready(): 
	get = texture_scale

func _process(delta):
	texture_scale = lerp(texture_scale,to,0.15)

func _on_Timer_timeout():
	to = get + rand_range(-0.5,0.5)
