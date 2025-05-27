extends Node3D

@onready var fire_vfx: Node3D = $FireVFX  # Make sure this points to your instanced scene
var max_scale = Vector3(3.0, 4.0, 3.0)
var start_scale = Vector3(0.001, 0.001, 0.001)
var current_growth_time = 0.0
var max_growth_time = 10.0
var is_burning = false

func _ready():
	fire_vfx.visible = false
	fire_vfx.scale = start_scale

func start_burning():
	print("🔥 Fire started!")
	fire_vfx.visible = true
	fire_vfx.scale = start_scale
	current_growth_time = 0.0
	is_burning = true

func _process(delta):
	if is_burning and current_growth_time < max_growth_time:
		current_growth_time += delta
		var progress = current_growth_time / max_growth_time
		fire_vfx.scale = start_scale.lerp(max_scale, progress)
