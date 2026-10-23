extends State

class_name Walk


@export var sprite: AnimatedSprite2D
@export var player: CharacterBody2D
const SPEED = 300.0

func enter():
	#player = get_tree().get_first_node_in_group('Character')
	sprite.play("run")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update(delta: float):
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		transition.emit(self, "jump")
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if !direction:
		transition.emit(self, "idle")
	
	if direction:
		player.velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
	else:
		# плавная остановка
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
