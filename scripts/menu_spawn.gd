extends Node3D

@export var xr_camera: Node3D  # Assign your XR camera node here in the inspector
@export var menu_distance: float = 2.0  # How far in front of the camera to spawn

func _ready():
	if xr_camera:
		var cam_transform = xr_camera.global_transform
		var forward = cam_transform.basis.z.normalized()

		var new_position = cam_transform.origin + forward * menu_distance
		
		global_transform.origin = new_position

	else:
		print("Please assign the XR camera node in the inspector!")
