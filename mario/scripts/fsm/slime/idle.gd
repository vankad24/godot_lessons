extends State


func enter():
	sprite.play("idle")
	
func update(delta: float):
	#if Input.get_axis("ui_left", "ui_right"):
		#transition.emit(self, "walk")
	pass
