extends Node2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var state = "idle"

func _ready() -> void:
	pass	
	



func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		state="jump"
	elif Input.is_action_pressed("ui_down"):
		pass
	elif Input.is_action_pressed("ui_left"):
		state="walk"
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		state="walk"
		sprite.flip_h = false
	else:
		state="idle"
	animation.play(state)
		
