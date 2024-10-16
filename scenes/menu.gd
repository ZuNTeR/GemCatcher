extends CanvasLayer
@onready var options: CanvasLayer = $Options
@onready var records: CanvasLayer = $records
var file_name = "user://name_scores.txt"
var file = "user://scores.txt"

func _ready() -> void:
	get_tree().paused = false
	if FileAccess.file_exists("user://scores.txt") and FileAccess.file_exists("user://name_scores.txt"):
		pass
	else:
		print("ALisosnsss")
		var file_name = FileAccess.open("user://name_scores.txt", FileAccess.WRITE)
		var file = FileAccess.open("user://scores.txt", FileAccess.WRITE)
		file_name.store_string("0 : AAAAA")
		file.store_string("0")
		file.close()



func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_records_pressed() -> void:
	records.visible = true 

func _on_options_pressed() -> void:
	options.visible = true

func _on_exit_desktop_pressed() -> void:
	get_tree().quit()
