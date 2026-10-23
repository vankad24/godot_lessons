extends State

class_name DoubleJump

@export var sprite: AnimatedSprite2D
@export var player: CharacterBody2D

const JUMP_VELOCITY = -400.0
const SPEED = 300.0


func enter():
	player.velocity.y = JUMP_VELOCITY
	sprite.play("double_jump")
	pass
	
func update(delta: float):
	var direction := Input.get_axis("ui_left", "ui_right")
	if !direction:
		transition.emit(self, "idle")
	if direction:
		player.velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
	
	
	if player.is_on_floor():
		transition.emit(self, "idle")
	elif player.velocity.y > 0:
		transition.emit(self, "fall")
		

	#if Input.get_axis("ui_left", "ui_right"):
		#transition.emit(self, "walk")
	pass
	
func exit():
	pass
