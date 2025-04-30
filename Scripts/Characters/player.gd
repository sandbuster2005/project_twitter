extends CharacterBody2D

@export_category("Propriétés")
@export var Speed : int

@onready var gravity = VariableManager.gravity

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = gravity
