class_name Player extends CharacterBody2D

@export_category("Walk/Run")
@export var Speed : int = 700
@export var Acceleration : int = 5600

@export_category("Jump")
@export var Jump_strength = 1500
@export var jumpMax = 2

@export_category("Dash")
@export var Dash_delay = 50
@export var Dash_duration = 20
@export var Dash_strength = 1500
var Dash_dir = 0

@export_category("Attack")
@export var dammage = 50
@export var knockback = 30

@export_category("Life")
@export var health = 100
@export var health_max = 100
@export var health_min = 0

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
		elif velocity.y <= 3000:
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
		if Dash_cooldown < Dash_delay-Dash_duration:
			velocity.x = move_toward(velocity.x, direction * Speed, Acceleration * delta)
		
		if Input.is_action_pressed("dash") and not Dash_cooldown and is_on_floor():
			if direction != 0:
				Dash_cooldown = Dash_delay
				velocity.y = 0
				Dash_dir = direction
		
		if Dash_cooldown > Dash_delay-Dash_duration:
			velocity.x = Dash_strength*Dash_dir*sin((Dash_cooldown-Dash_delay)/Dash_duration+PI/2)
			
		
		move_and_slide()
 
