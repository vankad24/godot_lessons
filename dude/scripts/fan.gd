extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var particles = $GPUParticles2D
@onready var fan_player = $AudioStreamPlayer2D

var active = false



func turn_on():
	sprite.play("on")
	fan_player.play()
	active = true
	particles.emitting = true
	
	
func turn_off():
	sprite.play("off")
	fan_player.stop()
	active = false
	particles.emitting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
