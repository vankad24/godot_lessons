extends Node2D

var speed: float = 0
var speed_step: float = 200
var rotation_step: float = 6
var max_speed: float = 500
var velocity: Vector2 = Vector2(0, 0)
var shield_restore_time: float = 3
var shield_restore_left: float = 0

@onready var speed_label: Label = get_node("speedometer")
@onready var shield = get_node("ship/shield")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		speed += speed_step * delta
		if speed > max_speed:
			speed = max_speed
	if Input.is_action_pressed("ui_down"):
		speed -= speed_step * delta
		if speed < 0:
			speed = 0
	if Input.is_action_pressed("ui_left"):
		rotation -= rotation_step * delta
	if Input.is_action_pressed("ui_right"):
		rotation += rotation_step * delta
	
	var x = 0.1 * cos(rotation+ PI / 2)
	var y = 0.1 * sin(rotation+ PI / 2)
	
	
	
	velocity = speed * delta * Vector2(x, y).normalized()
	
	position += velocity
	
	speed_label.text = "%d" % velocity.length()
	
	
	speed_label.rotation = velocity.angle_to(Vector2(0, 1))
	
	if shield_restore_left > 0:
		shield_restore_left -= delta
	else:
		shield.visible = true
	
	
func damaged():
	shield.visible = false
	shield_restore_left = shield_restore_time
