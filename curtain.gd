extends Node3D

@onready var fire_particles = $GPUParticles3D
var spread_speed = 0.3
var intensity_timer = 0.0
var max_particles = 200  # Maximum flame density

func start_burning():
	fire_particles.emitting = true
	# Start with minimal fire
	fire_particles.amount = 20  
	fire_particles.process_material.emission_box_extents = Vector3(0.3, 0.1, 0.1)

func _process(delta):
	if fire_particles.emitting:
		intensity_timer += delta
		
		# Gradually increase particle count (first 3 seconds)
		if intensity_timer < 3.0:
			fire_particles.amount = lerp(20, max_particles, intensity_timer/3.0)
		
		# Expand fire area
		var extents = fire_particles.process_material.emission_box_extents
		extents.x = min(extents.x + delta * spread_speed, 1.0)  # Width
		extents.y = min(extents.y + delta * spread_speed * 2, 2.0)  # Height
		fire_particles.process_material.emission_box_extents = extents
