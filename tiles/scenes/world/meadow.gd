extends Node2D

@onready var marker: Marker2D = $Spawn


func _place_character(character: CharacterBody2D):
	character.global_position = marker.global_position

func _ready() -> void:
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
