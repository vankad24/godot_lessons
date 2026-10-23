extends State

class_name Fall

@export var sprite: AnimatedSprite2D
@export var player: CharacterBody2D

const JUMP_VELOCITY = -400.0
const SPEED = 300.0


func enter():
	sprite.play("fall")
	
	
func update(delta: float):
	var direction := Input.get_axis("ui_left", "ui_right")
	if !direction:
		transition.emit(self, "idle")
	if direction:
		player.velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
	
	
	if player.is_on_floor():
		transition.emit(self, "idle")

	
func exit():
	player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
