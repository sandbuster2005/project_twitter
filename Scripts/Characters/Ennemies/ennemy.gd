extends CharacterBody2D
@export var Speed : int = 500 
@export var Acceleration : int = 5600 
var gravity = VariableManager.gravity
var direction = 1
func _process(delta: float) -> void:
	if randi() % 100 > 95:
		direction *= -1
	if not is_on_floor():
		velocity.y += gravity
		
	if is_on_wall():
		direction *= -1
		
	velocity.x = move_toward(velocity.x, direction * Speed, Acceleration * delta)
	move_and_slide()
