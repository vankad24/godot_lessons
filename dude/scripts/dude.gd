extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $dude_sprite

const SPEED = 200.0
const JUMP_SPEED = -400.0
const GRAVITY = 800
var DOUBLE_JUMP = true
const BOUNCE_DELAY = 0.4
var bounce_delay = 0.0
var bounce_count = 0
const bounce_max = 4

var state = "idle"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play(state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if bounce_delay > 0 and is_on_floor():
		bounce_delay -= delta
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if bounce_delay <= 0:
		velocity.x = direction * SPEED	
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			DOUBLE_JUMP = true
			bounce_count = 0
			velocity.y = JUMP_SPEED
		elif not is_on_floor() and DOUBLE_JUMP:
			velocity.y = JUMP_SPEED
			DOUBLE_JUMP = false
	
	if Input.is_action_pressed("ui_left"):
		state = "walk"
		sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		state = "walk"
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_up"):
		state = "jump"
	else:
		state = "idle"
	
	if not is_on_floor():
		animation.play("jump")
	elif direction != 0:
		sprite.flip_h = direction < 0
		animation.play("walk")
	else:
		animation.play("idle")
		
	move_and_slide()

	var collision_count = get_slide_collision_count()
	for i in collision_count:
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()
		var collider = collision.get_collider()
		if "box" in collider.name.to_lower():
			if normal.y > 0.8 : velocity += normal * SPEED * 1.1
		if "wall" in collider.name.to_lower():
			if abs(normal.x) > 0.8: velocity += normal * SPEED
			bounce_delay = BOUNCE_DELAY
		if "jumpbox" in collider.name.to_lower():
			if normal.y < -0.8:
				bounce_count = min(bounce_max, bounce_count + 1)
				velocity.y = normal.y * SPEED * bounce_count
				print(bounce_count)
