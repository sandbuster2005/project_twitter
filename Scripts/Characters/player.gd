class_name Player extends CharacterBody2D

@export_category("Walk/Run")
@export var Speed : int = 700
@export var Acceleration : int = 5600

@export_category("Jump")
@export var Jump_strength = 1500
@export var Dash_strength = 1205
@onready var Dash_cooldown : float = 0

var Move = true 
var dash = 0
@onready var gravity = VariableManager.gravity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Move:
		if not is_on_floor() and Dash_cooldown<20 and velocity.y <= 3000:
			velocity.y += gravity
		
		if Input.is_action_pressed("Up") and is_on_floor():
			velocity.y = -Jump_strength
		
		if Dash_cooldown !=0 :
			Dash_cooldown -= 1
		
		dash = 0
		
		if Input.is_action_pressed("dash") and not Dash_cooldown:
			dash = Dash_strength
			Dash_cooldown = 30
			velocity.y = 0
		
		var direction := Input.get_axis("Left", "Right")
		velocity.x = move_toward(velocity.x, direction * Speed, Acceleration * delta) + (dash * direction)
		
		
		
		
		move_and_slide()
 
