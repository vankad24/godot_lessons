extends State

class_name Jump


func enter():
	actor.jump()
	sprite.play("jump")

	
func update(delta: float):
	var player = actor as CharacterBody2D
	var direction := Input.get_axis("ui_left", "ui_right")
	player.move(direction)
	
	if player.is_on_floor():
		transition.emit(self, "idle")
	elif player.velocity.y > 0:
		transition.emit(self, "fall")
	elif Input.is_action_just_pressed("ui_accept") and !player.is_on_floor():
		transition.emit(self, "double_jump")
		

	#if Input.get_axis("ui_left", "ui_right"):
		#transition.emit(self, "walk")
	pass
	
func exit():
	pass
