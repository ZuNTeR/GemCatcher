extends Area2D
class_name Paddle

@export var speed: float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var gamenode = get_tree().get_root().find_node("game", true, false)
	#gamenode.connect(area)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_pressed("left"):
	#	position.x += -speed * delta
	#if Input.is_action_pressed("right"):
	#	position.x += speed * delta
	global_position.x += delta * speed * Input.get_axis("left", "right")
	if global_position.x < 80:
		global_position.x = 80
	elif global_position.x > 1072:
		global_position.x = 1072
	
		


#func _on_parede_direita_area_entered(area: Area2D) -> void:
#	Input.action_press("left")

#func _on_parede_direita_area_exited(area: Area2D) -> void:
#	Input.action_release("left")


#func _on_parede_esquerda_area_entered(area: Area2D) -> void:
#	Input.action_press("right")

#func _on_parede_esquerda_area_exited(area: Area2D) -> void:
#	Input.action_release("right")
