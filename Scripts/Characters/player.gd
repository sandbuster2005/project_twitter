class_name Player extends CharacterBody2D

@export_category("Walk/Run")
@export var Speed : int = 505
@export var Acceleration : int = 3000

@export_category("Jump")
@export var Jump_strength = 1205
@export var Jump_sound : AudioStreamPlayer2D


var Move = true 
@onready var gravity = VariableManager.gravity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Move:
		if not is_on_floor():
			velocity.y += gravity

		print(velocity)
		
		if Input.is_action_pressed("Up") and is_on_floor():
			velocity.y = -Jump_strength
			
		var direction := Input.get_axis("Left", "Right") * Speed
		velocity.x = move_toward(velocity.x, direction, Acceleration * delta)
		
		move_and_slide()
