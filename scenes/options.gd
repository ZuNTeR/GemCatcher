extends CanvasLayer
@onready var file = FileAccess.open("user://name_scores.txt", FileAccess.READ)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_check_button_toggled(button_pressed) -> void:
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_restart_records_pressed() -> void:
	var file = FileAccess.open("user://name_scores.txt", FileAccess.WRITE)
	var file_name = FileAccess.open("user://scores.txt", FileAccess.WRITE)
	file_name.store_string("")
	file.store_string("")
	file.close()


func _on_back_pressed() -> void:
	visible = false
