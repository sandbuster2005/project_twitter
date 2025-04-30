extends CharacterBody2D

@export_category("Propriétés")
@export var Speed : int

var move = true 
@onready var gravity = VariableManager.gravity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if move:
		if not is_on_floor():
			velocity.y += gravity/10
			
		print(velocity.y)
		print(velocity.x)
		print(velocity)
		if velocity.x!=0:
			if velocity.x < 0:
				velocity.x += Speed/10
				
			else:
				velocity.x -= Speed/10
		
		if Input.is_action_pressed("Up") and is_on_floor():
			velocity.y = -Speed*5
		
		if Input.is_action_pressed("Down"):
			pass
			
		if Input.is_action_pressed("Right"):
			velocity.x = Speed
			
		if Input.is_action_pressed("Left"):
			velocity.x = -Speed
			
		move_and_slide()
		
