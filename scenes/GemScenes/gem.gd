extends Area2D
signal on_gem_off_screen
@export var speed: float = 100.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	
	
#	if position.y > get_viewport_rect().size.y + 25.0:
#		on_gem_off_screen.emit()
#		set_process(false)
#		queue_free()
#		set_process(true)
func _on_paredebaixo_area_entered(area: Area2D) -> void:
	on_gem_off_screen.emit()
	set_process(false)
	queue_free()
	set_process(true)
	print 
