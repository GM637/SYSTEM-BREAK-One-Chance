tool
extends TextureRect

export var speed = 480
var target : KinematicBody2D = null
var motion = Vector2()
var to = Vector2()

func _physics_process(delta):
	
	$Area2D/CollisionShape2D.position.y = rect_size.y / 2 - 24
	$Area2D/CollisionShape2D.shape.extents.y = rect_size.y / 2
	$Area2D/CollisionShape2D.position.x = rect_size.x / 2 - 24
	$Area2D/CollisionShape2D.shape.extents.x = rect_size.x / 2
	
	if target != null and target.has_method("conveyor") :
		
		motion = Vector2.DOWN * speed 
		motion = motion.rotated(deg2rad(rect_rotation))
		to = to.linear_interpolate(motion,0.2)
		to = target.move_and_slide(to)

func _on_Area2D_body_entered(body):
	target = body

func _on_Area2D_body_exited(body):
	target = null
