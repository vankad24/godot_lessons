extends Node2D

var current_level: Node2D = null
var levels: Dictionary = {
	"training": preload("res://scenes/levels/training_level.tscn")
}

var player = null

@onready var world = $World
@onready var player_scene = preload("res://scenes/characters/physics_dude.tscn")
@onready var menu = $UI/Menu

func _ready() -> void:
	player = player_scene.instantiate()
	
	load_level("training")
	add_child(player)
	
	print(current_level.get_node("Spawn").global_position)	
	
	
func _process(delta: float) -> void:
	pass


func load_level(name):
	if current_level:
		current_level.queue_free()
	if name in levels:
		current_level = levels[name].instantiate()
		world.add_child(current_level)
		player.position = current_level.get_node("Spawn").global_position
		
func pause():
	if not menu.visible:
		get_tree().paused = true
		menu.visible = true
	else:
		get_tree().paused = false
		menu.visible = false
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause()
	
		
	
