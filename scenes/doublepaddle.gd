extends Area2D
class_name DoublePaddle
@export var speed: float = 800.0
@onready var collision_left: CollisionPolygon2D = $CollisionLeft
@onready var collision_right: CollisionPolygon2D = $CollisionRight
var double = true

func _process(delta: float) -> void:
	if double and Input.is_action_pressed("left_arrow") or Input.is_action_pressed("right_arrow"):
		double = false
	if double:
		global_position.x += delta * speed * Input.get_axis("left", "right")
		global_position.x = clamp(global_position.x, 130.0, 1790.0)
	else:
		collision_left.global_position.x += delta * speed * Input.get_axis("left", "right")
		collision_right.global_position.x += delta * speed * Input.get_axis("left_arrow", "right_arrow")
		collision_left.global_position.x = clamp(collision_left.global_position.x, 65.0, 1855.0)
		collision_right.global_position.x = clamp(collision_right.global_position.x, 65.0, 1855.0)
