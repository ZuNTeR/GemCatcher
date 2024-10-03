extends Area2D
class_name DoublePaddle
@export var speed: float = 500.0
@onready var sprite_left: Sprite2D = $SpriteLeft
@onready var sprite_right: Sprite2D = $SpriteRight
@onready var collision_left: CollisionPolygon2D = $CollisionLeft
@onready var collision_right: CollisionPolygon2D = $CollisionRight
@onready var area_right: Area2D = $AreaRight
@onready var area_left: Area2D = $AreaLeft

var left_limit: float = 80.0
var right_limit: float = 1072.0

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
		global_position.x += delta * speed * Input.get_axis("left", "right")
		if global_position.x < left_limit:
			global_position.x = left_limit
		elif global_position.x > right_limit:
			global_position.x = right_limit
	else:
		sprite_left.global_position.x += delta * speed * Input.get_axis("left", "right")
		collision_left.global_position.x = sprite_left.global_position.x
		
		if sprite_left.global_position.x < 39.0:
			sprite_left.global_position.x = 39.0
		elif sprite_left.global_position.x > 1113:
			sprite_left.global_position.x = 1113
			
		sprite_right.global_position.x += delta * speed * Input.get_axis("left_arrow", "right_arrow")
		collision_right.global_position.x = sprite_right.global_position.x
		
		if sprite_right.global_position.x < 39.0:
			sprite_right.global_position.x = 39.0
		elif sprite_right.global_position.x > 1113:
			sprite_right.global_position.x = 1113
