extends Area2D
class_name Paddle
@export var speed: float = 800.0

func _process(delta: float) -> void:
	global_position.x += delta * speed * Input.get_axis("left", "right")
	global_position.x = clamp(global_position.x, 125, 1790)
