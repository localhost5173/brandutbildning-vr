extends XRController3D

@onready var _controller := XRHelpers.get_xr_controller(self)
@onready var smoke_particles = $"../../PickableObject/FireExtinguisher2/Nozzle/Particles"
@onready var click_sound_player: AudioStreamPlayer = $ClickSoundPlayer
@onready var spray_area: Area3D = $"../../PickableObject/FireExtinguisher2/Nozzle/SprayArea"
@onready var fireparticles: GPUParticles3D = $"../../Fire/Flames"
var is_emitting := false
var is_held := false

@export var fireEnable : String = "trigger_click"
@export var click_sound : AudioStream

func _ready():
	await get_tree().process_frame
	_controller = XRHelpers.get_xr_controller(self)
	spray_area.body_entered.connect(_on_spray_area_body_entered)
	click_sound_player = AudioStreamPlayer.new()

	if click_sound is AudioStream:
		var stream = click_sound.duplicate()
		if stream is AudioStreamOggVorbis or stream is AudioStreamMP3 or stream is AudioStreamWAV:
			stream.loop = true
		click_sound_player.stream = stream

	add_child(click_sound_player)


func _process(_delta):
	if is_held and _controller and _controller.is_button_pressed(fireEnable) or Input.is_action_pressed("test"):
		if not is_emitting:
			print("🔥 Trigger pressed")
			smoke_particles.emitting = true
			is_emitting = true
			click_sound_player.play()
	else:
		if is_emitting:
			print("🛑 Trigger released")
			smoke_particles.emitting = false
			is_emitting = false
			click_sound_player.stop()

func _on_object_picked_up(pickable: Variant) -> void:
	is_held = true
	print("Picked up: emitting enabled")

func _on_object_put_down(pickable: Variant) -> void:
	is_held = false
	print("Put down: emitting disabled")
	if is_emitting:
		smoke_particles.emitting = false
		is_emitting = false
		click_sound_player.stop()

func _on_spray_area_body_entered(body: Node3D) -> void:
	if not is_emitting:
		return

	var parent = body.get_parent()
	if parent.name.begins_with("Fire"):
		print("🔥 Fire extinguished! Starting countdown...")
		
		# Optional: fade out or play animation here before removing


		await get_tree().create_timer(2.0).timeout
		if parent and parent.is_inside_tree():
			parent.queue_free()
