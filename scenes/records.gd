extends CanvasLayer
@onready var record_1: Label = $Record1

func _process(delta: float) -> void:
	var file_name = FileAccess.open("user://name_scores.txt", FileAccess.READ)
	var file = FileAccess.open("user://scores.txt", FileAccess.READ)
	var saved_score = file_name.get_line()
	if int (saved_score) <= 0:
		record_1.text = ""
	else:
		record_1.text = saved_score

func _on_back_pressed() -> void:
	visible = false
