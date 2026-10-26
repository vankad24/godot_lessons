extends Node
class_name State

signal transition(
	old_state: State,
	new_state_name: String
)

var actor: Node
var sprite: AnimatedSprite2D
var state_machine: FSM


func enter() -> void:
	pass


func exit() -> void:
	pass


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass
