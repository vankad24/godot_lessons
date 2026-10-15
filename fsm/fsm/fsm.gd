extends Node

class_name FSM

var states: Dictionary = {}
var current_state: State
@export var initial_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			print("added state:", child.name)
			states[child.name.to_lower()] = child
