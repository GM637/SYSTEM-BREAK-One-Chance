extends KinematicBody2D

# An example implementation of top-down player controls.

export var speed = 320
export var amount = 0.1
onready var velocity = Vector2()

var dir = 0
var input_dir = Vector2()
var spawn = position
var weapon = ""

onready var metaboy = $MetaBoy
onready var camerapoint = $Camera
onready var animplayer = $Animation
onready var dodgecheck = $DodgeRay/DodgeCheck
onready var dodgeray = $DodgeRay
onready var gun = $Gun

func _ready():
	spawn = position
	metaboy.part_background.hide()
	get_tree().call_group("Enemy", "set_player" , self)

func _process(delta):
	
	weapon = metaboy.metaboy_data.weapon
	camerapoint.global_position = global_position.linear_interpolate(get_global_mouse_position(),0.4)
	
	$Camera/Camera2D.zoom.x = 0.8 + ( Engine.time_scale * 0.2 )
	$Camera/Camera2D.zoom.y = 0.8 + ( Engine.time_scale * 0.2 )
	
	if weapon == "Bazooka" :
		gun.used_ammo = 100
		gun.gain_ammo = 0
		gun.reload = 5
		gun.recoil = 960
		gun.slowmo = 0.3
		gun.slowmodur = 1
	
	if weapon == "Surrender-Flag" :
		gun.used_ammo = 5
		gun.gain_ammo = 0
		gun.reload = 3
		gun.recoil = 128
		gun.slowmo = 0.5
		gun.slowmodur = 2
	
	if "Lightning" in weapon :
		gun.used_ammo = 15
		gun.gain_ammo = 7
		gun.reload = 3
		gun.recoil = 0
		gun.slowmo = 0.2
		gun.slowmodur = 0.4
	
	if weapon == "Katana" :
		gun.used_ammo = 5
		gun.gain_ammo = 5
		gun.reload = 5
		gun.recoil = -480
		gun.slowmo = 0.3
		gun.slowmodur = 1
	
	if weapon == "Hook" or weapon == "Harpoon" or "Gravity" in weapon :
		gun.used_ammo = 10
		gun.gain_ammo = 5
		gun.reload = 5
		gun.recoil = -960
		gun.slowmo = 0.3
		gun.slowmodur = 1
	
	if "Golden" in weapon :
		gun.used_ammo = 5
		gun.gain_ammo = 5
		gun.reload = 7
		gun.recoil = 0
		gun.slowmo = 0.25
		gun.slowmodur = 0.5
	
	if "Neon" in weapon :
		gun.used_ammo = 10
		gun.gain_ammo = 5
		gun.reload = 5
		gun.recoil = 0
		gun.slowmo = 0.5
		gun.slowmodur = 2
	
	if "Laser" in weapon :
		gun.used_ammo = 3
		gun.gain_ammo = 0
		gun.reload = 2
		gun.recoil = 640
		gun.slowmo = 0.7
		gun.slowmodur = 0.5
	
	if "Bow" in weapon :
		gun.used_ammo = 100
		gun.gain_ammo = 0
		gun.reload = 8
		gun.recoil = 124
		gun.slowmo = 0.6
		gun.slowmodur = 1.5

func set_attributes(attributes: Dictionary) -> void:
	metaboy.set_metaboy_attributes(attributes)

func _physics_process(_delta: float) -> void:
	
	# Movement
	if !animplayer.is_playing() :
		input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir.length_squared() > 1.0 :
		input_dir = input_dir.normalized()
	velocity = velocity.linear_interpolate(input_dir * speed , amount) 
	move_and_slide(velocity)
	
	dodgeray.look_at(dodgecheck.global_position + velocity)
	
	dir = input_dir.x
	if dir == 0 :
		dir = 1
	if input_dir.y != 0 :
		dir = 1
	
	#dodge
	if !animplayer.is_playing() and Input.is_action_just_pressed("dodge") and !dodgecheck.is_colliding():
		animplayer.play("Roll" , -1 , dir , dir == -1 ) 
		$Jump.play()
	
	# Animations
	if abs(velocity.x) > 0.1 or abs(velocity.y) > 0.1 :
		metaboy.animation_player.play("run",-1, velocity.length() / 64 * metaboy.body_root.scale.x * dir )
	else:
		metaboy.animation_player.play("idle")
	if global_position.x < get_global_mouse_position().x :
		metaboy.body_root.scale.x = 1
	elif global_position.x > get_global_mouse_position().x :
		metaboy.body_root.scale.x = -1

func recoil(num):
	velocity = ( Vector2.RIGHT * -num )
	velocity = velocity.rotated($Gun.rotation)

func reset():
	get_tree().reload_current_scene()

func is_player():
	pass

func conveyor():
	pass
