# NPC.gd
extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var detection_area: Area3D = $Area3D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var mesh: Node3D = $"NPC (1)" # Adjust to your actual mesh path

@export var walk_speed := 1.5
@export var run_speed := 6.0
@export var panic_time := 5.0
@export var area_size := 10.0

var current_velocity: Vector3 = Vector3.ZERO
var is_panicking := false
var panic_timer := 0.0

func _ready():
	randomize()
	detection_area.body_entered.connect(_on_area_3d_body_entered)
	_set_random_target()

func _physics_process(delta):
	if is_panicking:
		panic_timer -= delta
		if panic_timer <= 0:
			is_panicking = false
			_set_random_target()
		_move_panic(delta)
		anim_player.play("run")
	else:
		if nav_agent.is_navigation_finished():
			_set_random_target()
		else:
			_move_path(delta)
			anim_player.play("walk")

func _set_random_target():
	var random_pos = global_position + Vector3(
		randf_range(-area_size, area_size),
		0,
		randf_range(-area_size, area_size)
	)
	nav_agent.set_target_position(random_pos)

func _move_path(delta):
	var next_point = nav_agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	current_velocity = direction * walk_speed
	velocity = current_velocity
	_move_and_face()

func _move_panic(delta):
	var random_dir = Vector3(
		randf_range(-1, 1),
		0,
		randf_range(-1, 1)
	).normalized()
	current_velocity = random_dir * run_speed
	velocity = current_velocity
	_move_and_face()

func _move_and_face():
	move_and_slide()
	if current_velocity.length() > 0.01:
		var look_dir = current_velocity.normalized()
		mesh.look_at(global_position + look_dir, Vector3.UP)
		mesh.rotate_y(deg_to_rad(180)) # Face forward if mesh looks backward by default

func trigger_panic():
	is_panicking = true
	panic_timer = panic_time

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name.contains("Fire"):
		trigger_panic()
