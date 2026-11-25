extends Node2D

@onready var player_scene = preload("res://scenes/player/player.tscn")
var player: CharacterBody2D 

func _ready() -> void:
	player = player_scene.instantiate()
	GameWorld._set_player(player)
	GameWorld._set_world($World)
	GameWorld._load_level("meadow")
	$World.add_child(player)
	

func _process(delta: float) -> void:
	pass
