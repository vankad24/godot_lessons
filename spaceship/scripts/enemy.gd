extends Node2D


var acceleration: Vector2 = Vector2(0, 0)
var velocity: Vector2 = Vector2(0, 0)
var max_force: float = 5
var max_speed: float = 5
var max_distance: int = 400
var min_distance: int = 20

@onready var window = get_parent().get_window()
#@onready var size = get_node("Asteroid").texture.get_size()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#apply_force(Vector2(15, 2))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity += acceleration * delta
	velocity = velocity.limit_length(max_speed)
	position += velocity
	acceleration *= 0
	rotation = velocity.angle()
	fix_position()

func fix_position():
	
	position.x = int(position.x) % window.size.x
	position.y = int(position.y) % window.size.y
	
	if position.x < 0:
		position.x = window.size.x
	
	if position.y < 0:
		position.y = window.size.y
	
		
	
	

func apply_force(force: Vector2):
	acceleration = force
	
func seek(target: Vector2):
	var direction = target - position
	#if direction.length() > max_distance:
		#return
	#if direction.length() <= min_distance:
		#velocity*=0
		#return
	
	var ratio = 1#remap(direction.length(), min_distance, max_distance, 0, 1)
	var desired_velocity = direction.normalized() * max_speed
	var steering = (desired_velocity - velocity) * ratio
	steering = steering.limit_length(max_force)
	
	apply_force(steering)
	

func flee(target: Vector2):
	var direction = position - target
	if direction.length() > max_distance:
		return
	var ratio = remap(direction.length(), min_distance, max_distance, 1, 0)
	var desired_velocity = direction.normalized() * max_speed
	var steering = (desired_velocity - velocity) * ratio
	steering = steering.limit_length(max_force)
	apply_force(steering)
	
func pursue(target: Vector2, target_velocity: Vector2):
	var direction = target - position
	var speed: float = velocity.length()
	if speed == 0:
		speed = max_speed
	var ahead_time: float = direction.length() / speed
	
	var predict = target + target_velocity * ahead_time
	seek(predict)


func evade(target: Vector2, target_velocity: Vector2):
	var direction = target - position
	var speed: float = velocity.length()
	if direction.length() > max_distance:
		return
	if speed == 0:
		speed = max_speed
	var ahead_time: float = direction.length() / speed
	
	var predict = target + target_velocity * ahead_time
	flee(predict)
	
func separate(group: Node2D):
	var steering: Vector2 = Vector2.ZERO
	var count: int = 0
	for child in group.get_children():
		if self == child:
			continue
		var direction: Vector2 = child.position - position
		var distance:float = direction.length()
		if distance >= 0 and distance < max_distance:
			var away: Vector2 = -direction.normalized()
			away *= (1/distance)
			
			steering += away
			count += 1
			
	if count > 0:
		steering /= count
		steering = steering.normalized() * max_speed
		steering -= velocity
		steering = steering.limit_length(max_force)
		apply_force(steering)

func cohesion(group: Node2D):
	var center: Vector2 = Vector2.ZERO
	var count: int = 0
	for child in group.get_children():
		var direction: Vector2 = child.position - position
		var distance:float = direction.length()
		
		if distance >= 0 and distance < max_distance:
			count += 1
			center+=child.position
	if count > 0:
		center /= 	count
		
		seek(center)
	
	
func alignment(group: Node2D):
	var mean_velocity: Vector2 = Vector2.ZERO
	var count: int = 0
	for child in group.get_children():
		var direction: Vector2 = child.position - position
		var distance:float = direction.length()
		if distance >= 0 and distance < max_distance:
			count += 1
			mean_velocity+=child.velocity
				
	if count > 0:
		mean_velocity /= 	count
		
		mean_velocity = mean_velocity.normalized() * max_speed
		mean_velocity -= velocity
		var steering = mean_velocity - velocity
		
		apply_force(steering.limit_length(max_force))
