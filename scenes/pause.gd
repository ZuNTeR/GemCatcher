extends CanvasLayer
@onready var resume: Button = $menu_holder/Resume


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#	if Input.is_action_just_pressed("esc"):
#		chamar_pause()

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		visible = true
		get_tree().paused = true
		resume.grab_focus()
		
		
		
#func chamar_pause():
#		visible = true
#		get_tree().paused = true
#		resume.grab_focus()
		

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	

func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_menu_pressed() -> void:
	pass # Replace with function body.


func _on_exit_desktop_pressed() -> void:
	get_tree().quit()
