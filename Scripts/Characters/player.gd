class_name Player extends CharacterBody2D

@export_category("Walk/Run")
@export var Speed : int = 505
@export var Acceleration : int = 3000

@export_category("Jump")
@export var Jump_strength = 1205
@export var Dash_strength = 1205
@export var Jump_sound : AudioStreamPlayer2D
@onready var Dash_cooldown : float = 0

var Move = true 
@onready var gravity = VariableManager.gravity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Move:
		if not is_on_floor():
			velocity.y += gravity
		
		if Input.is_action_pressed("Up") and is_on_floor():
			velocity.y = -Jump_strength
		
		if Dash_cooldown !=0 :
			Dash_cooldown -= 1
		
		var direction := Input.get_axis("Left", "Right") * Speed
		velocity.x = move_toward(velocity.x, direction, Acceleration * delta)
		
		if Input.is_action_pressed("dash") and not Dash_cooldown:
			if velocity.x > 0:
				velocity.x += Dash_strength 
			else :
				velocity.x -= Dash_strength
			Dash_cooldown = 30
		
		
		move_and_slide()
 
