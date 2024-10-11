extends CanvasLayer
class_name pause
@onready var options: CanvasLayer = $Options
@onready var resume: Button = $menu_holder/Resume

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	pass

func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		visible = true
		get_tree().paused = true

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_options_pressed() -> void:
	options.visible = true
	#visible = false

func _on_exit_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_exit_desktop_pressed() -> void:
	get_tree().quit()




func _on_options_visibility_changed() -> void:
	if options.visible == true:
		visible = false
	else:
		visible = true
