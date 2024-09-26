extends Area2D


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
	position.x += delta * speed * Input.get_axis("left", "right")
	#if position.x < 80:
	#	position.x = 80
	#elif position.x > 1072:
	#	position.x = 1072
	
		


func _on_parede_direita_area_entered(area: Area2D) -> void:
	position.x = 1074


func _on_parede_esquerda_area_entered(area: Area2D) -> void:
	position.x = 80
