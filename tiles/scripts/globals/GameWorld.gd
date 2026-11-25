extends Node

@onready var levels = {
	"meadow": "res://scenes/world/meadow.tscn",
	"random_forest": "res://scenes/world/random_forest.tscn",
}

var world: Node2D = null
var player: CharacterBody2D = null
var current_level: Node2D

func _set_world(node: Node2D):
	world = node
	
func _set_player(character: CharacterBody2D):
	player = character

func _load_level(name: String):
	if current_level:
		world.remove_child(current_level)
		current_level.queue_free()
	var node: Node2D = load(levels[name]).instantiate()
	current_level = node
	world.add_child(node)
	node._place_character(player)
