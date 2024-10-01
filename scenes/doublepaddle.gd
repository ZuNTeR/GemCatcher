extends Area2D
@export var speed: float = 500.0
@onready var sprite_left: Sprite2D = $SpriteLeft
@onready var sprite_right: Sprite2D = $SpriteRight
@onready var collision_left: CollisionPolygon2D = $CollisionLeft
@onready var collision_right: CollisionPolygon2D = $CollisionRight
var double = false
var minXPosition = -300



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
		if sprite_right.position.x < minXPosition and collision_right.position.x < minXPosition:
			sprite_right.position.x = minXPosition
			collision_right.position.x = minXPosition
		elif sprite_left.position.x < minXPosition and collision_left.position.x < minXPosition:
			sprite_left.position.x = minXPosition
			collision_left.position.x = minXPosition
			
		elif sprite_right.position.x > 1072 and collision_right.position.x > 1072:
			sprite_right.position.x = 1072
			collision_right.position.x = 1072
		elif sprite_left.position.x > 1072 and collision_left.position.x > 1072:
			sprite_left.position.x = 1072
			collision_left.position.x = 1072
			
			
			
			
			
			
			
			
			
			
			
			
