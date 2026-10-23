extends State

class_name Idle

@export var sprite: AnimatedSprite2D
@export var player: CharacterBody2D



func enter():
	sprite.play("idle")
	
func update(delta: float):
	if Input.get_axis("ui_left", "ui_right"):
		transition.emit(self, "walk")
	
		# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		transition.emit(self, "jump")
