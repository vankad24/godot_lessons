extends Node2D


@export var max_health: int = 5
@export var health_texture: Texture2D

var current_helth: int = max_health:
	set(value):
		current_helth=value
		update_health()


func _ready() -> void:
	update_health()

func update_health():
	var container: HBoxContainer = $Panel/HBoxContainer
	if container:
		for child in container.get_children():
			child.queue_free()
		
		for i in max_health:
			var health = TextureRect.new()
			health.texture = health_texture
			health.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
			container.add_child(health)
			
