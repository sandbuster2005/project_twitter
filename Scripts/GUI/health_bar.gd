extends TextureProgressBar

func _process(delta: float) -> void:
	min_value = EventManager.Player_health_min
	max_value = EventManager.Player_health_max
	value = EventManager.Player_health
