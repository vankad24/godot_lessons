extends Node2D

var current_level: Node2D = null
var levels: Dictionary = {
	"training": preload("res://scenes/levels/training_level.tscn"),
	"infinity": preload("res://scenes/levels/infinity.tscn"),
}

var player = null

@onready var world = $World
@onready var player_scene = preload("res://scenes/characters/physics_dude.tscn")
@onready var menu = $UI/Menu


func _ready() -> void:
	player = player_scene.instantiate()
	
	load_level("training")
	add_child(player)
	
	menu.update_levels(levels.keys())
	load_level(levels.keys()[0])
	menu.level_changed.connect(load_level)
	
	print(current_level.get_node("Spawn").global_position)	
	
	load_settings()
	
	
func _process(delta: float) -> void:
	pass


func load_level(name):
	if current_level:
		current_level.queue_free()
	if name in levels:
		current_level = levels[name].instantiate()
		world.add_child(current_level)
		player.position = current_level.get_node("Spawn").global_position
	var camera: Camera2D = player.get_node("Camera2D")
	match name:
		"training": camera.enabled = false
		"infinity": 
			camera.enabled = true
			camera.limit_left = 0
			camera.limit_bottom = 648
			camera.limit_top = 0
			current_level.camera = camera
			current_level.player = player
			
		
	
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
	
	
func save_settings():
	var config: ConfigFile = ConfigFile.new()
	var settings = menu.get_settings()
	for key in settings:
		config.set_value("general", key, settings[key])
		config.save("user://dude.cfg")
	
	
func load_settings():	
	#await get_parent().ready # wait root node to finish init and @onready

	var config: ConfigFile = ConfigFile.new()
	var result = config.load("user://dude.cfg")
	var settings: Dictionary = {}
	if result == OK:
		for key in config.get_section_keys("general"):
			settings[key] = config.get_value("general", key)
			
	
	menu.load_settings(settings)
