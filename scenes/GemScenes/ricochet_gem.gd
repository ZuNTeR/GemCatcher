extends Area2D
class_name RicochetGem
@export var speed: float = 100.0
@onready var label: Label = $Label
var ricochetCaptureX = 0

func _on_area_entered(area: Area2D) -> void:
	if area is Gem:
		ricochetCaptureX += 1
		label.text = "%01d" % ricochetCaptureX
