extends CharacterBody2D
@export var Speed : int = 500 
@export var Acceleration : int = 5600 
var gravity = VariableManager.gravity
var direction : int = 1
var cible = Node

func _process(delta: float) -> void:
	if cible != Node:
		direction = min(max(cible.position.x - position.x,-1),1)
	if  randi() % 100 > 95:
		direction *= -1
	if not is_on_floor():
		velocity.y += gravity
		
	if is_on_wall():
		direction *= -1
	
	velocity.x = move_toward(velocity.x, direction * Speed, Acceleration * delta)
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		cible = body
