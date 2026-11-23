extends Node2D

var camera: Camera2D
var player: CharacterBody2D

@onready var platforms = $Platforms

@export var platform_scene: PackedScene
@export var offscreen_distance: float = 300
@export var min_gap: float = 50
@export var max_gap: float = 150
@export var min_y: float = 300
@export var max_y: float = 500

var right_x: float = 0
var left_x: float = 0

var difficulty: float = 1
var max_difficulty: float = 2

var spawned: Array[Node] = []

func create_platform(x: float):
	if not platform_scene:
		return
	
	var platform = platform_scene.instantiate()
	platform.position.x = x
	platform.position.y = randf_range(min_y, max_y)
	
	platforms.add_child(platform)
	spawned.append(platform)
	
	difficulty = min(difficulty+0.2, max_difficulty)
	
	

func _ready() -> void:
	difficulty = 1


func _process(delta: float) -> void:
	print("Platforms ", spawned.size())
	var screen_size = get_viewport_rect().size
	var camera_pos = camera.global_position
	var half_w = screen_size.x / 2
	var left_edge = camera_pos.x - half_w
	var right_edge = camera_pos.x + half_w
	
	while right_x < right_edge + offscreen_distance:
		create_platform(right_x + randf_range(min_gap, max_gap)*difficulty)
		right_x = spawned[-1].position.x
		
	for i in range(spawned.size()-1, -1, -1):
		var platform = spawned[i]
		if platform.position.x < left_edge - offscreen_distance:
			platform.queue_free()
			spawned.remove_at(i)
			
	
	
	
