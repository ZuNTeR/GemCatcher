extends CanvasLayer
@onready var options: CanvasLayer = $Options
@onready var records: CanvasLayer = $records

func _ready() -> void:
	get_tree().paused = false

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_records_pressed() -> void:
	records.visible = true 

func _on_options_pressed() -> void:
	options.visible = true

func _on_exit_desktop_pressed() -> void:
	get_tree().quit()
