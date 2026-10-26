extends State

class_name Fall

func enter():
	sprite.play("fall")
	
	
func update(delta: float):
	var player = actor as CharacterBody2D
	var direction := Input.get_axis("ui_left", "ui_right")
	player.move(direction)
	
	
	if player.is_on_floor():
		transition.emit(self, "idle")

	
func exit():
	actor.stop()
