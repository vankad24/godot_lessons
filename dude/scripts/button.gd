extends Area2D

@export var node_path: NodePath


var node: Node
var active: bool = false
@onready var sprite: Sprite2D = $Sprite2D



func _ready() -> void:
	node = get_node(node_path)


func activate():
	if node:
		if node.has_method("turn_on") and not active:
			sprite.texture = load("res://assets/off_button.png")
			node.turn_on()
			active = true
		elif node.has_method("turn_off") and active:
			sprite.texture = load("res://assets/on_button.png")
			node.turn_off()
			active = false
			
