extends CanvasLayer
@onready var record_1: Label = $Record1
@onready var file = FileAccess.open("user://name_scores.txt", FileAccess.READ)

func _process(delta: float) -> void:
	var saved_score = file.get_line()
	record_1.text = saved_score

func _on_back_pressed() -> void:
	visible = false
