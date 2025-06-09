extends Node3D

@onready var fire_vfx: Node3D = $FireVFX
@onready var fire_sound = $AudioStreamPlayer

var max_scale = Vector3(1.5, 2.0, 1.5)
var start_scale = Vector3(0.1, 0.1, 0.1)
var current_growth_time = 0.0
var max_growth_time = 4.0
var is_burning = false

func _ready():
	fire_vfx.visible = false
	fire_vfx.scale = start_scale
	add_to_group("fire_target")  # 🔌 Let extinguisher find this by group

func start_burning():
	fire_vfx.visible = true
	fire_vfx.scale = start_scale
	current_growth_time = 0.0
	is_burning = true
	fire_sound.play()

func slacken_fire():
	if !is_burning:
		return
	is_burning = false
	print("🧯 Fire is being extinguished...")
	var tween = get_tree().create_tween()
	tween.tween_property(fire_vfx, "scale", start_scale, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(Callable(fire_vfx, "hide"))
