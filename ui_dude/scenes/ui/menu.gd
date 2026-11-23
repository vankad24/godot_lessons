extends Node2D

@onready var slider = $CenterContainer/VBoxContainer/HBoxContainer/HSlider
@onready var option_button: OptionButton = $CenterContainer/VBoxContainer/OptionButton

signal level_changed(value)


func _unpause():
	get_tree().paused = false
	hide()

func _on_exit():
	get_tree().quit()

	
func _on_volume_changed(value: float):
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(bus, value)

func get_settings():
	var settings: Dictionary = {"volume":slider.value}
	return settings
	
func load_settings(settings: Dictionary):
	var volume = settings.get("volume", 1)
	slider.value = volume

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
	

func update_levels(levels: Array):
	for level in levels:
		option_button.add_item(level)
		
		
func on_level_button(value):
	_unpause()
	level_changed.emit(option_button.get_item_text(value))
	
	
