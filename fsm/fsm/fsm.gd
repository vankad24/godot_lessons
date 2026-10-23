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
			child.transition.connect(change_state)
	if initial_state:
		initial_state.enter()
		current_state = initial_state
	
	
func change_state(old_state: State, new_state_name: String):
	if old_state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return 
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		

	
	
	
	
	
	
	
