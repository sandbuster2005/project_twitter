extends CharacterBody2D

var gravity = VariableManager.gravity

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity
