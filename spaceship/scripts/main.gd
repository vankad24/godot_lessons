extends Node2D

@onready var player = get_node("Player")
@onready var enemy = $Enemy
@onready var asteroid = get_node("Asteroid")
@onready var enemies: Node2D = $Enemies
@onready var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")

@onready var window = get_parent().get_window()

var enemy_count: int = 10

var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	asteroid.collided.connect(player.damaged)
	for i in enemy_count:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.scale = Vector2(0.5, 0.5)
		
		var x = rand.randi_range(0, window.size.x)
		var y = rand.randi_range(0, window.size.y)
		enemy_instance.position.x = x
		enemy_instance.position.y = y
		
		enemy_instance.velocity.x = rand.randi_range(0, 10)
		enemy_instance.velocity.y = rand.randi_range(0, 10)
			
		enemies.add_child(enemy_instance)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#enemy.flee(player.position)
	for child in enemies.get_children():
		#child.cohesion(enemies)
		child.alignment(enemies)
		
	#enemy.pursue(player.position, player.velocity)
	
