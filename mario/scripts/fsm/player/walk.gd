extends State


func enter():
	#player = get_tree().get_first_node_in_group('Character')
	sprite.play("run")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update(delta: float):
	var player = actor as CharacterBody2D

	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		transition.emit(self, "jump")
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if !direction:
		transition.emit(self, "idle")
	
	if direction:
		player.move(direction)
	else:
		# плавная остановка
		player.stop()
