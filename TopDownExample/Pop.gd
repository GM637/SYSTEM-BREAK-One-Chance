extends Polygon2D

var parent = null
var quote = [
	"GuardBot.exe stopped \n responding... !@#@$$@",
	"GuardBot left the server early",
	"GuardBot got MAIMED",
	"DOXXED MOMENT LMAO",
	"Credit Card Stolen >:P"
]

func _ready():
	global_position = parent.global_position
	global_rotation = deg2rad(rand_range(-15,15))
	$Text.text = str(quote[rand_range(0,4)])
	if !parent.has_method("is_enemy") :
		$Text.visible = false

