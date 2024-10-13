extends CanvasLayer
var nome

func _ready() -> void:
	visible = false

func _on_line_edit_text_submitted(new_text: String) -> void:
	nome = new_text
	visible = false
