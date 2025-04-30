extends CharacterBody2D

@export_category("Propriétés")
@export var Vitesse : int

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not is_on_floor():
		pass
	pass
