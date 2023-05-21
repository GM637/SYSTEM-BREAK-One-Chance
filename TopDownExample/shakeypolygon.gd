extends Polygon2D

export var freq = 0.1
export var amp = 1

var polys = PoolVector2Array()

func _ready():
	polys = polygon
	$Timer.wait_time = freq

func _on_Timer_timeout():
	for n in polys.size() :
		polygon[n].x = polys[n].x + rand_range(-amp,amp)
		polygon[n].y = polys[n].y + rand_range(-amp,amp)
