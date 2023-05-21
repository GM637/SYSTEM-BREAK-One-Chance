extends KinematicBody2D

export var speed = 240
export var sight = 120
export var accel = 0.2

var player : KinematicBody2D = null

var motion = Vector2()
var to = Vector2()
var angle = 0

func _ready():
	add_to_group("Enemy")

func set_player(p):
	player = p

func _physics_process(delta):
	
	if get_parent().visible == false :
		$Node2D/Detect.enabled = false
		$Collider.disabled = true
		return
	
	if player == null:
		return
	
	if position.distance_to(player.position) > sight + 180 :
		visible = false
		return
	
	$Node2D/Detect.enabled = true
	$Collider.disabled = false
	visible = true
	
	if position.distance_to(player.position) < sight :
		to = Vector2.RIGHT * speed
		angle = get_angle_to(player.position)
		motion = motion.linear_interpolate(to.rotated(angle),accel)
	
	$Node2D.look_at(global_position + motion)
	motion = move_and_slide(motion)
	
	if $Node2D/Detect.is_colliding() and $Node2D/Detect.get_collider() == player :
		get_tree().current_scene.respawn()
		

func kill():
	queue_free()

func is_enemy():
	pass

func conveyor():
	pass
