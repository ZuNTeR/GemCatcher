extends Area2D
class_name RicochetGem
@export var ricochet: bool = false
@export var speed: float = 100.0
@export var areaEntered = false
@export var numeroRicochets = 0
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	#if areaEntered == true and Input.is_action_pressed("up"):
	#	ricochet = true
	#if ricochet == true:
	#	areaEntered = false
	#	position.y -= speed * delta
	#else:
	#	position.y += speed * delta
	#if position.y > get_viewport_rect().size.y + 25.0:
		#set_process(false)
		#queue_free()
		#set_process(true)


#func _on_area_entered(area: Area2D) -> void:
#	if numeroRicochets != 1:
#		if area is Paddle or area is DoublePaddle:
#			areaEntered = true
#			numeroRicochets = 1
#	else:
#		pass