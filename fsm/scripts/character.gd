extends CharacterBody2D




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("slime"):
		pass
