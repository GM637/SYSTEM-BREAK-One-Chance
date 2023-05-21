extends Polygon2D

var parent = null
var checkrot = 0.0

func _ready():
	global_position = parent.global_position
	global_rotation = parent.global_rotation
	checkrot = wrapf(global_rotation_degrees,0,360)
	if checkrot > 90 and checkrot < 270 :
		scale.y  = -1
	
