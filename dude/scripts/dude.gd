extends Node2D

@onready var animation = $AnimationPlayer


func _ready() -> void:
	animation.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
