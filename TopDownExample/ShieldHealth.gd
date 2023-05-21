extends StaticBody2D

func _process(delta):
	$CollisionShape2D.disabled = not get_parent().get_parent().visible

func kill():
	queue_free()
