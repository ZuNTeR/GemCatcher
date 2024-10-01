extends Area2D
@export var speed: float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_pressed("left"):
	#	position.x += -speed * delta
	#if Input.is_action_pressed("right"):
	#	position.x += speed * delta
	position.x += delta * speed * Input.get_axis("left", "right")
	if position.x < 80:
		position.x = 80
	elif position.x > 1072:
		position.x = 1072
