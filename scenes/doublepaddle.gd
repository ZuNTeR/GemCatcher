extends Area2D
class_name DoublePaddle
@export var speed: float = 500.0
@onready var sprite_left: Sprite2D = $SpriteLeft
@onready var sprite_right: Sprite2D = $SpriteRight
@onready var collision_left: CollisionPolygon2D = $CollisionLeft
@onready var collision_right: CollisionPolygon2D = $CollisionRight
var double = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_pressed("left"):
	#	position.x += -speed * delta
	#if Input.is_action_pressed("right"):
	#	position.x += speed * delta
	
	if !double and Input.is_action_pressed("left_arrow") or Input.is_action_pressed("right_arrow"):
		double = true
	if double == false:
		position.x += delta * speed * Input.get_axis("left", "right")
		if position.x < 80:
			position.x = 80
		elif position.x > 1072:
			position.x = 1072
	else:
		sprite_left.position.x += delta * speed * Input.get_axis("left", "right")
		collision_left.position.x += delta * speed * Input.get_axis("left", "right")
		sprite_right.position.x += delta * speed * Input.get_axis("left_arrow", "right_arrow")
		collision_right.position.x += delta * speed * Input.get_axis("left_arrow", "right_arrow")	
			
			
func _on_area_entered(area: Area2D) -> void:
	if _on_parede_direita_area_entered:
		pass
func _on_parede_direita_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_parede_esquerda_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
