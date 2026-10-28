extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $dude_sprite
@onready var step_player: AudioStreamPlayer = $AudioStreamPlayer


var random = RandomNumberGenerator.new()

const SPEED = 200.0
const JUMP_SPEED = -400.0
const GRAVITY = 800
var DOUBLE_JUMP = true
const BOUNCE_DELAY = 0.4
var bounce_delay = 0.0
var bounce_count = 0
const bounce_max = 4

const PICKUP_DISTANCE = 40
const THROW_FORCE = 400
var held_box: RigidBody2D = null



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
	
	var direction = Input.get_axis("left", "right")
	if bounce_delay <= 0:
		velocity.x = direction * SPEED	
	
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			DOUBLE_JUMP = true
			bounce_count = 0
			velocity.y = JUMP_SPEED
		elif not is_on_floor() and DOUBLE_JUMP:
			velocity.y = JUMP_SPEED
			DOUBLE_JUMP = false
	
	if Input.is_action_pressed("left"):
		state = "walk"
		sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		state = "walk"
		sprite.flip_h = false
	elif Input.is_action_pressed("up"):
		state = "jump"
	else:
		state = "idle"
	
	if not is_on_floor():
		animation.play("jump")
	elif direction != 0:
		sprite.flip_h = direction < 0
		animation.play("walk")
		if not step_player.playing:
			step_player.play()
	else:
		animation.play("idle")
		step_player.stop()
		
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
				
		if "rock" in collider.name.to_lower():
			collider.apply_impulse(-normal * 10)
			
	if held_box:
		held_box.global_transform.origin = global_position + Vector2(0, -50)
		
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pickup") and not held_box:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsShapeQueryParameters2D.new()
		var shape = CircleShape2D.new()
		shape.radius = PICKUP_DISTANCE
		query.shape = shape
		query.transform = Transform2D(0, global_position)
		query.collide_with_areas = true
		query.exclude = [self]
		var results = space_state.intersect_shape(query)
		for hit in results:
			if "box" in hit.collider.name.to_lower() and hit.collider is RigidBody2D:
				held_box = hit.collider
				held_box.hold(self)
				break
			elif hit.collider is Area2D:
				if hit.collider.has_method("activate"):
					hit.collider.activate()
					
	if event.is_action_pressed("action") and held_box:
		var direction = Vector2.LEFT if sprite.flip_h else Vector2.RIGHT
		direction.y = -0.5
		var impulse = direction * THROW_FORCE
		held_box.release(impulse)
		held_box = null
	
		
		
