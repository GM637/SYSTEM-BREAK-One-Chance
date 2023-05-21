extends Node2D

onready var metaboy_character = $YSort/MetaPlayer
onready var gunbar = get_node("%GunBar")
onready var gun = $YSort/MetaPlayer/Gun
onready var trans = $UI/Trans2
onready var timer = $UI/Time/Clock
var timestamps = PoolStringArray()
var combo = 0
var comboquote = [
	"",
	"NICE ! :P",
	"AMAZING ! >:D",
	"IMPRESSIVE HACKING !",
	"FIREWALL-BREAKING :O",
	"! IN-DOXX-ICATING ! >:P",
	"MOM's CREDIT CARD \n WORHTY AAAAA",
]

var time = 0
var end = false

func _ready():
	Engine.time_scale = 1
	$CanvasModulate.visible = true
	$BG.visible = true
	$UI.visible = true
	
	# Set the MetaBoy character to the one the player selected.
	metaboy_character.set_attributes(MetaBoyGlobals.selected_metaboy.get_attributes_as_dictionary())
	
	gun.connect("shooted",self,"gun_shoot")
	gun.connect("landed",self,"gun_hit")


func _process(delta):
	
	$"UI/Top UI/GunBar/AmmoText".text = "AMMO : " + str(metaboy_character.weapon)
	
	combo = clamp(combo,0,comboquote.size()-1)
	$UI/Combo.text = str(comboquote[combo])
	
	timer.text = ""
	time += delta
	
	if gun.shoot == false :
		gunbar.value += gun.reload 
		if gunbar.value >= 100 :
			gun.shoot = true
			$SFX/Reload.stop()
	
	if timestamps.size() != 0 :
		for t in timestamps :
			timer.text += t + "\n"
	
	if !end :
		timer.text += str(wrapi(time/60,0,60)) + ":" + str(wrapi(time,0,60)) + ":" + str(wrapi(time * 100,0,100))

func _on_ConnectWallet_pressed():
	get_tree().change_scene("res://UI/LoginScreen.tscn")

func gun_shoot():
	gunbar.value -= gun.used_ammo
	$SFX/Shotgun.play()
	if gunbar.value < 1 :
		gun.shoot = false
		$SFX/Reload.play(0)

func gun_hit():
	gunbar.value += gun.gain_ammo
	$UI/Speedlines.visible = true
	$UI/Combo/ComboAnim.play("WHAM")
	$UI/Combo/ComboAnim.seek(0)
	Engine.time_scale = gun.slowmo
	$Slowmo.wait_time = gun.slowmodur * Engine.time_scale
	$Slowmo.start()


func respawn() :
	trans.play("Reset")

func stamp(name):
	timestamps.append(str(name) + " " + str(wrapi(time/60,0,60)) + ":" + str(wrapi(time,0,60)) + ":" + str(wrapi(time * 100,0,100)))

func _on_final_stamp_trigger(body):
	if body.has_method("is_player") :
		$YSort/LastEnemies.visible = true
		pass

func _on_LastKey_clicked():
	$SFX/RUN.play()
	$Events.play("RUN")

func _on_endingTrigger(body):
	if body.has_method("is_player") :
		$Events.play("Ending")

func end_time():
	$YSort/LastEnemies.visible = false
	end = true

func _on_Slowmo_timeout():
	Engine.time_scale = 1
	$UI/Speedlines.visible = false
