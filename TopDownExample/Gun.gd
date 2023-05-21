extends RayCast2D

export var recoil = 0.1
export var used_ammo = 10
export var gain_ammo = 5
export var reload = 2
export var slowmo = 0.1
export var slowmodur = 0.4


var shoot = true

onready var player = get_parent()
onready var bang = preload("res://TopDownExample/MuzzleFX.tscn")
onready var pop = preload("res://TopDownExample/Pop.tscn")

signal shooted
signal landed

func _ready():
	$Target.set_as_toplevel(true)

var collided = null

func _physics_process(delta):
	
	look_at(get_global_mouse_position())
	
	$Target.visible  = false
	
	$Line2D.points[1].x = 500
	if is_colliding() :
		$Line2D.points[1].x = global_position.distance_to(get_collision_point()) + 12
		if get_collider() is KinematicBody2D or get_collider() is StaticBody2D :
			$Target.global_position = get_collider().global_position
			$Target.visible = true
	
	if Input.is_action_just_pressed("shoot") and shoot:
		$GunAnims.play("RESET")
		$GunAnims.play("Shoot")
		emit_signal("shooted")
		if is_colliding() :
			collided = get_collider()
			if collided.has_method("kill"):
				var fx = pop.instance()
				fx.parent = collided
				get_tree().current_scene.add_child(fx)
				emit_signal("landed")
				collided.kill()
			if collided.has_method("is_enemy") :
				$Poof.play()
				get_tree().current_scene.combo += 1
			else :
				get_tree().current_scene.combo = 0

func player_recoil():
	
	player.recoil(recoil)
	var muzzle = bang.instance()
	muzzle.parent = self
	get_tree().current_scene.add_child(muzzle)

