extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var particles = $GPUParticles2D
@onready var player = $AudioStreamPlayer2D

var active = false
var switch_interval = 3
var switch_time_left = 0



func turn_on():
	sprite.play("on")
	player.play()
	active = true
	particles.emitting = true
	

func turn_off():
	sprite.play("off")
	player.stop()
	active = false
	particles.emitting = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	switch_time_left-=delta
	if switch_time_left <= 0:
		switch_time_left = switch_interval
		if active:
			turn_off()
		else:
			turn_on()
			
	
