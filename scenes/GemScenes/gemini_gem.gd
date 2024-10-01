extends Area2D
class_name GeminiGem
@export var speed: float = 100.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 25.0:
		set_process(false)
		queue_free()
		set_process(true)
