extends Node3D

@onready var timer = $IgniteTimer

func _ready():
	# Flame is always on
	$GPUParticles3D.emitting = true
	$OmniLight3D.visible = true
	
	timer.wait_time = 5.0
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	# Method 1: Find by node name (recommended)
	var curtain = get_tree().root.find_child("Curtain", true, false)
	
	# Method 2: If curtain is sibling in scene tree
	# var curtain = get_parent().get_node("Curtain")
	
	if curtain and curtain.has_method("start_burning"):
		curtain.start_burning()
	else:
		print("Curtain found:", curtain != null) # Debug help
