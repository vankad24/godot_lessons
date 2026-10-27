extends Node

class_name FSM

@export var initial_state: State

var states: Dictionary = {}
var current_state: State
var actor: Node

func _ready() -> void:
	await get_parent().ready # wait root node to finish init and @onready
	actor = get_parent()
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.actor = actor
			child.state_machine = self
			child.transition.connect(change_state)

	if initial_state:
		current_state = initial_state
		current_state.enter()
	else:
		current_state = State.new()

	
func change_state(old_state: State, new_state_name: String):
	print("change state", new_state_name)
	if old_state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return 
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	
func _process(delta: float) -> void:
	current_state.update(delta)
		

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
	
	
	
	
	
	
	
