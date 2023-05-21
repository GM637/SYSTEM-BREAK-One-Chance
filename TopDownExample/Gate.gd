extends Sprite

func open():
	frame = 1
	$StaticBody2D/CollisionShape2D.disabled  = true
	$Light2D.visible = true

func close():
	frame = 0
	$StaticBody2D/CollisionShape2D.disabled  = false
	$Light2D.visible = false
