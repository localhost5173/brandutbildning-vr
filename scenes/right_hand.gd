extends XRController3D

@onready var _controller := XRHelpers.get_xr_controller(self)
@onready var smoke_particles = $"../../PickableObject/FireExtinguisher2/Nozzle/Particles"
var is_emitting := false
var is_held := false
@export var fireEnable : String = "trigger_click"

func _ready():
	await get_tree().process_frame
	_controller = XRHelpers.get_xr_controller(self)
	print("🚨 FireExtinguisher ready")
	print("My parent: ", get_parent())
	print("Controller detected: ", _controller)

func _process(_delta):
	if is_held and _controller and _controller.is_button_pressed(fireEnable) or Input.is_action_pressed("test"):
		if not is_emitting:
			print("🔥 Trigger pressed")
			smoke_particles.emitting = true
			is_emitting = true
	else:
		if is_emitting:
			print("🛑 Trigger released")
			smoke_particles.emitting = false
			is_emitting = false

func _on_object_picked_up(pickable: Variant) -> void:
	is_held = true
	print("Picked up: emitting enabled")

func _on_object_put_down(pickable: Variant) -> void:
	is_held = false
	print("Put down: emitting disabled")
	if is_emitting:
		smoke_particles.emitting = false
		is_emitting = false
