extends Node2D

var speed: int = 300
var velocity: Vector2 = Vector2(0, 0)
var angular_speed: float = 0.1

var rand = RandomNumberGenerator.new()

@onready var window = get_parent().get_window()
@onready var size = get_node("Sprite2D").texture.get_size()

#signal collided

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(randi_range(-speed, speed), randi_range(-speed, speed))
	angular_speed = randf_range(0.1, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	rotation+= angular_speed * delta
	
	if position.x + size.x / 2 > window.size.x:
		velocity.x *= -1
	elif position.x - size.x / 2 < 0:
		velocity.x *= -1
	elif position.y + size. y/ 2 > window.size.y:
		velocity.y *= -1
	elif position.y - size.y / 2 < 0:
		velocity.y *= -1
	


#func _on_area_area_entered(area: Area2D) -> void:
	#print(area.is_in_group("asteroid"))
	#collided.emit()
	
	
