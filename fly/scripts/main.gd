extends Node2D


var rng = RandomNumberGenerator.new()

@export var nflies: int = 10
@onready var fly_scene = preload("res://scenes/fly_scene.tscn")
@onready var bee_scene = preload("res://scenes/BeeScene.tscn")
@onready var script1 = preload("res://scripts/random_step.gd")
@onready var script2 = preload("res://scripts/noises.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in nflies:
		#print("create fly", " ", i)
		var scene = fly_scene
		if rng.randf() < 0.3:
			scene = bee_scene
		var inst = scene.instantiate()
		
		if rng.randf() < .5:
			inst.set_script(script1)
		else:
			inst.set_script(script2)
			
		add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
