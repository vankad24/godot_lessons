extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var state = "idle"
const SPEED = 200
const JUMP_SPEED = -400
const GRAVITY = 800



func _ready() -> void:
	pass	
	


func process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_SPEED
	
	
	
	#if Input.is_action_pressed("ui_up"):
		#state="jump"
	#elif Input.is_action_pressed("ui_down"):
		#pass
	#elif Input.is_action_pressed("ui_left"):
		#state="walk"
		#sprite.flip_h = true
	#elif Input.is_action_pressed("ui_right"):
		#state="walk"
		#sprite.flip_h = false
	#else:
		#state="idle"
	#animation.play(state)
		
	if not is_on_floor():
		animation.play("jump")
	elif direction != 0:
		sprite.flip_h = direction < 0
		animation.play("walk")
	else:
		animation.play("idle")
		
		
	move_and_slide()
	
	
