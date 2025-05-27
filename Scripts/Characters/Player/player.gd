class_name Player extends CharacterBody2D

signal death
signal update_health(health, healthMax, healthMin)

@export_category("Settings")
@export_group("Walk")
@export var Speed : int = 700
@export var Acceleration : int = 5600

@export_group("Jump")
@export var Jump_strength = 1500
@export var jumpMax = 2

@export_group("Dash")
@export var Dash_delay = 50
@export var Dash_duration = 20
@export var Dash_strength = 1500
@export var Invincible : bool = false
var Dash_dir = 0

@export_group("Attack")
@export var dammage = 50
@export var knockback = 30

@export_group("Life")
@export var health = 100
@export var health_max = 100

@onready var Dash_cooldown : float = 0

var Move = true 
var jumpNum = jumpMax
var was_on_floor = true

@onready var collision_area = $Area2D
@onready var gravity = VariableManager.gravity

func _ready() -> void:
	update_health.connect(EventManager._on_health_update)
	_update_health()

func _process(delta: float):
	if Move:
		if is_on_floor():
			if !was_on_floor:
				Input.start_joy_vibration(1,1,0,0.1)
				was_on_floor = true
			if jumpNum == -1 and Input.is_action_pressed("Up"):
				jumpNum = jumpMax - 1
				velocity.y = -Jump_strength
			else:
				jumpNum = jumpMax
		elif velocity.y <= 3000:
			velocity.y += gravity
			was_on_floor = false
		
		if Input.is_action_just_pressed("Up"):
			if jumpNum > 0:
				Input.start_joy_vibration(1,0.5,0.1,0.1)
				jumpNum -= 1
				velocity.y = -Jump_strength
			else:
				jumpNum = -1
		
		if Dash_cooldown !=0 :
			Dash_cooldown -= 1
		
		var direction := Input.get_axis("Left", "Right")
		if direction:
			$Sprite.scale.x = -sign(direction) * 0.05
		
		if Dash_cooldown < Dash_delay-Dash_duration:
			velocity.x = move_toward(velocity.x, direction * Speed, Acceleration * delta)
			$Sprite.rotation = 0
			Invincible = false
			set_collision_layer_value(1,true)
		
		if Input.is_action_pressed("dash") and not Dash_cooldown and is_on_floor():
			if direction != 0:
				Dash_cooldown = Dash_delay
				velocity.y = 0
				Dash_dir = sign(direction) * 1
		
		if Dash_cooldown > Dash_delay-Dash_duration:
			Input.start_joy_vibration(1, 0, 0.5, 0.1)
			$Sprite.rotation += Dash_dir * 0.5
			Invincible = true
			set_collision_layer_value(1,false)
			velocity.x = Dash_strength*Dash_dir*sin((Dash_cooldown-Dash_delay)/Dash_duration+PI/2)
		if health <=0:
			death.emit()		
		move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !Invincible and "Ennemy" in body.name:
		$AnimationPlayer.play("hurt")
		health -= body.dammage
		velocity.x += body.knockback * body.direction_to(body.position.x, position.x) * 1000
		Input.start_joy_vibration(1, 1, 1, 0.7)
		_update_health()

func _update_health():
	update_health.emit(health, health_max, 0)

		
