extends CharacterBody2D



const JUMP_VELOCITY = -400.0
const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func jump():
	velocity.y = JUMP_VELOCITY

func move(direction):
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0

func stop():
	velocity.x = move_toward(velocity.x, 0, SPEED)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	move_and_slide()



func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("slime"):
		pass
