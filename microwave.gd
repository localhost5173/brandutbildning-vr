extends Node3D

@onready var heating_sound = $AudioStreamPlayer3D_Heating
@onready var explosion_sound = $AudioStreamPlayer3D_Explosion
@onready var fire_sound = $AudioStreamPlayer3D_Fire
@onready var explosion_timer = $Timer
@onready var fire_vfx = $FireVFX

var start_scale = Vector3(0.1, 0.1, 0.1)
var max_scale = Vector3(1.5, 2.0, 1.5)

func _ready():
	fire_vfx.visible = false
	fire_vfx.scale = start_scale
	explosion_timer.wait_time = 10.0
	explosion_timer.timeout.connect(_on_explosion)
	heating_sound.play()
	explosion_timer.start()

func _on_explosion():
	heating_sound.stop()
	explosion_sound.play()
	fire_sound.play()
	
	# Show and grow fire
	fire_vfx.visible = true
	fire_vfx.scale = start_scale
	var tween = get_tree().create_tween()
	tween.tween_property(fire_vfx, "scale", start_scale, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
