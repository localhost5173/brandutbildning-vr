extends Control

@onready var StartLayer = $StartLayer
@onready var SettingsLayer = $SettingsLayer
@onready var SimulationsLayer = $SimLayer
@onready var Sim1Layer = $Sim1Layer
@onready var Sim2Layer = $Sim2Layer
@onready var Sim3Layer = $Sim3Layer


func _on_settings_button_pressed() -> void:
	StartLayer.visible = false
	SettingsLayer.visible = true
	
func _on_sim_button_pressed() -> void:
	StartLayer.visible = false
	SimulationsLayer.visible = true



func _on_back_button_1_pressed() -> void:
	SettingsLayer.visible = false
	StartLayer.visible = true
	
func _on_back_button_2_pressed() -> void:
	SimulationsLayer.visible = false
	StartLayer.visible = true

func _on_back_button_3_pressed() -> void:
	Sim1Layer.visible = false
	SimulationsLayer.visible = true
	
func _on_back_button_4_pressed() -> void:
	Sim2Layer.visible  = false
	SimulationsLayer.visible = true
	
func _on_back_button_5_pressed() -> void:
	Sim3Layer.visible = false
	SimulationsLayer.visible = true


func _on_test_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_start_sim_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_start_sim_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_start_sim_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
