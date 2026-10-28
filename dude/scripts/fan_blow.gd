extends Area2D

@export var force = Vector2(0, -20)

@onready var fan = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if fan.active:
		for body in get_overlapping_bodies():
			if body is CharacterBody2D:
				body.velocity += force
			elif body is RigidBody2D:
				body.apply_impulse(force)
				
			
			
