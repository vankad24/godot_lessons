extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var isAlive: bool = true


func _ready() -> void:
	sprite.play("idle")

func _process(delta: float) -> void:
	pass

func die():
	if not isAlive:
		return
	isAlive = false
	sprite.play("dead")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		die()
