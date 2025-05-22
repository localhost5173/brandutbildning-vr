extends CharacterBody3D

@export var walk_speed := 1.5
@export var run_speed := 6.0
@export var panic_time := 5.0
@export var area_size := 10.0

var current_velocity := Vector3.ZERO
var is_panicking := false
var panic_timer := 0.0

func _ready():
	randomize()
	_choose_new_direction()

func _physics_process(delta):
	if is_panicking:
		panic_timer -= delta
		if panic_timer <= 0:
			is_panicking = false
			_choose_new_direction()
		_move(run_speed, delta)
	else:
		_move(walk_speed, delta)

func _move(speed: float, delta: float):
	move_and_slide()

	# Stay within bounds
	if global_position.length() > area_size:
		_choose_new_direction()

func _choose_new_direction():
	var random_dir = Vector3(
		randf_range(-1.0, 1.0),
		0,
		randf_range(-1.0, 1.0)
	).normalized()
	current_velocity = random_dir

func trigger_panic():
	is_panicking = true
	panic_timer = panic_time
	_choose_new_direction()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name.contains("Fire"):  # Or use group, tag, etc.
		trigger_panic()

	pass # Replace with function body.
