extends Node2D

@onready var slider = $CenterContainer/VBoxContainer/HBoxContainer/HSlider

func _unpause():
	get_tree().paused = false
	hide()

func _on_exit():
	get_tree().quit()

	
func _on_volume_changed(value: float):
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(bus, value)

func get_settings():
	var settings: Dictionary = {"valume":slider.value}
	return settings
	
func load_settings(settings: Dictionary):
	var volume = settings.get("valume", 1)
	slider.value = volume

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
