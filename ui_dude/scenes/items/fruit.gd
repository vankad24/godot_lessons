extends Node2D

signal end_game

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_and_show(x: float, y: float):
	position.x = x
	position.y = y
	visible = true
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if visible and body is CharacterBody2D:
		print("You won!")
		end_game.emit()
