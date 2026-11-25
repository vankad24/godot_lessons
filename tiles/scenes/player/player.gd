extends CharacterBody2D

@export var tree: AnimationTree

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * 200
	tree.set("parameters/blend_position", velocity.normalized())
	
	move_and_slide()
