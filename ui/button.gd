extends Button

 
@export var hover_sound: AudioStream
@export var click_sound: AudioStream
@export var sound_delay: float = 0.2  # Fördröjning i sekunder innan scenbyte
 
var audio_player: AudioStreamPlayer
 
func _ready():
	# Skapa en dedikerad ljudspelare
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	# Koppla signaler

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	# Återställ viewport-inställningar
	get_viewport().transparent_bg = false
	get_viewport().handle_input_locally = true
 
func _on_mouse_entered():
	_on_hover()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)
 
func _on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
 
func _on_hover():
	if hover_sound:
		audio_player.stream = hover_sound
		audio_player.play()
 
func _on_click():
	if click_sound:
		audio_player.stream = click_sound
		audio_player.play()
 
func _on_pressed():
	_on_click()
	# Vänta med scenbytet tills ljudet spelats klart
	await get_tree().create_timer(sound_delay).timeout
	# Kontrollera att ljudet fortfarande spelas (för säkerhets skull)
	if audio_player.playing:
		await audio_player.finished
	# Byta scen
	get_tree().change_scene_to_file("res://scenes/oldmain.tscn")
