extends StaticBody2D


var direction = 1 if randf() < .5 else -1
var switch_interval = randf_range(3, 7)
var switch_time_left = 0
var speed = randf_range(5, 10)

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	switch_time_left-=delta
	position.y+=delta*speed*direction
	if switch_time_left <= 0:
		switch_time_left = switch_interval
		direction = -direction
			
	
