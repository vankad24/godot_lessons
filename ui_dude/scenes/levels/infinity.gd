extends Node2D

var camera: Camera2D
var player: CharacterBody2D
var hud: Node2D

@onready var platforms = $Platforms
@onready var spawn = $Spawn
@onready var fruit = $Fruit

@export var platform_scene: PackedScene
@export var offscreen_distance: float = 300
@export var min_gap: float = 80
@export var max_gap: float = 100
@export var min_y: float = 300
@export var max_y: float = 500

var right_x: float = 0
var left_x: float = 0

var difficulty: float = 1
var max_difficulty: float = 3

var game_started: bool = false
var spawned: Array[Node] = []

func create_platform(x: float):
	if not platform_scene:
		return
	
	var platform = platform_scene.instantiate()
	platform.position.x = x
	platform.position.y = randf_range(min_y, max_y)
	
	platforms.add_child(platform)
	spawned.append(platform)
	
	difficulty = min(difficulty+0.1, max_difficulty)
	
	if difficulty == max_difficulty:
		fruit.move_and_show(x, platform.position.y-100)
	

func start_game():
	game_started = false
	difficulty = 1
	player.position = spawn.global_position
	for i in range(spawned.size()):
		var platform = spawned[i]
		platform.queue_free()
	spawned.clear()
	create_platform(spawn.position.x)
	right_x = spawned[-1].position.x
	hud.restore()
	fruit.hide()
	game_started = true
	

func _ready() -> void:
	fruit.end_game.connect(start_game)


func _process(delta: float) -> void:
	var screen_size = get_viewport_rect().size
	var camera_pos = camera.global_position
	var half_w = screen_size.x / 2
	var left_edge = camera_pos.x - half_w
	var right_edge = camera_pos.x + half_w
	
	while game_started and difficulty != max_difficulty and right_x < right_edge + offscreen_distance:
		create_platform(right_x + randf_range(min_gap, max_gap)*difficulty)
		right_x = spawned[-1].position.x
		
	for i in range(spawned.size()-1, -1, -1):
		var platform = spawned[i]
		if platform.position.x < left_edge - offscreen_distance:
			platform.queue_free()
			spawned.remove_at(i)
			
	if player.position.y > screen_size.y:
		player_die()

func player_die():
	if hud.current_health > 0:
		hud.current_health -= 1
		for i in range(spawned.size()):
			var platform = spawned[i]
			if platform.position.x > 0:
				player.position.x = platform.position.x
				player.position.y = platform.position.y - 100
				break
	else:
		game_started = false
	
