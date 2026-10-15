extends State

class_name Idle

@export var sprite: AnimatedSprite2D


func enter():
	sprite.play("idle")
