extends Node3D

@onready var ignite_timer = $IgniteTimer

func _ready():
	ignite_timer.wait_time = 10.0
	ignite_timer.timeout.connect(_on_timer_timeout)
	ignite_timer.start()

func _on_timer_timeout():
	var curtain = get_parent().find_child("Curtain", true, false)
	if curtain and curtain.has_method("start_burning"):
		print("⏱️ Timer done, igniting curtain...")
		curtain.start_burning()
