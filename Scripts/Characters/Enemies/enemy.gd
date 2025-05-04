class_name Enemy extends CharacterBody2D

@export_category("Movement")
@export var speed : int = 500
@export var speed_max : Vector2 = Vector2(500,3000)
@export var wait_times : Array = [1,1.5,2]
var gravity = VariableManager.gravity
var direction : Vector2
var bord = false

@export_category("Attack")
@export var dammage = 10
@export var knockback = 3
@export var chasing : bool = false
var cible = Node

@export_category("Life")
@export var health = 50
@export var health_max = 100
@export var health_min = 0

func _process(delta: float) -> void:
	move()
	if (is_on_wall() or not $Node2D/RayCast2D.is_colliding()) and !chasing:
		velocity.x = 0
		$DirectionTimer.wait_time = choose(wait_times)
		direction.x *= -1

	if !is_on_floor():
		velocity.y += gravity
		velocity.x = 0

	velocity.x = max(min(speed_max.x, velocity.x), -speed_max.x)
	velocity.y = max(min(speed_max.y, velocity.y), -speed_max.y)
	$Node2D.scale.x = -direction.x 
	move_and_slide()

func move():
	if health > health_min:
		if !chasing:
			velocity += direction * speed
		else :
			velocity.x += direction_to(position.x, cible.position.x) * speed
			

func _on_direction_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose(wait_times)
	if !chasing:
		direction = choose([Vector2.LEFT,Vector2.RIGHT])
		velocity.x = 0

func direction_to(x,cible_x):
	var dir = max(min((cible_x-x)*10, 1), -1)
	return dir
	

func choose(array):
	array.shuffle()
	return array.front()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		cible = body
		chasing = true
