class_name Player extends CharacterBody2D

@export_category("Walk/Run")
@export var Speed : int = 700
@export var Acceleration : int = 5600

@export_category("Jump")
@export var Jump_strength = 1500
@export var Dash_strength = 1205
@export var jumpMax = 2
@onready var Dash_cooldown : float = 0

var Move = true 
var jumpNum = jumpMax

@onready var gravity = VariableManager.gravity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Move:
		if is_on_floor():
			if jumpNum == -1 and Input.is_action_pressed("Up"):
				jumpNum = jumpMax - 1
				velocity.y = -Jump_strength
			else:
				jumpNum = jumpMax
		elif Dash_cooldown<20 and velocity.y <= 3000:
			velocity.y += gravity
		
		if Input.is_action_just_pressed("Up"):
			if jumpNum > 0:
				jumpNum -= 1
				velocity.y = -Jump_strength
			else:
				jumpNum = -1
		
		if Dash_cooldown !=0 :
			Dash_cooldown -= 1
		
		var direction := Input.get_axis("Left", "Right")
		if Dash_cooldown < 20:
			velocity.x = move_toward(velocity.x, direction * Speed, Acceleration * delta)
		
		if Input.is_action_pressed("dash") and not Dash_cooldown:
			if direction != 0:
				velocity.x = Dash_strength*direction
				Dash_cooldown = 30
				velocity.y = 0
		
		
		
		
		move_and_slide()
 
