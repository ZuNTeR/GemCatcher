extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_exit_desktop_pressed() -> void:
	get_tree().quit()
