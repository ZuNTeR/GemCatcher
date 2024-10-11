extends CanvasLayer
var nome

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	


func _on_line_edit_text_submitted(new_text: String) -> void:
	nome = new_text
	visible = false
	
	
