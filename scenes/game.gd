extends Node2D

@export var gem_scene: PackedScene
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var audio_gema_capturada: AudioStreamPlayer2D = $AudioGemaCapturada
@onready var audio_gema_perdida: AudioStreamPlayer2D = $AudioGemaPerdida




#signal on_gem_touch_under_bound

var _score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func spawn_gem() -> void:
	var new_gem = gem_scene.instantiate()
	var xpos: float = randf_range(70, 1050)
	#new_gem.on_gem_off_screen.connect(lose_gem)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)

#func stop_all() -> void:
#	timer.stop()

func _on_timer_timeout() -> void:
	spawn_gem()
	
#func lose_gem() -> void:
#	_score -= 1
#	label.text = "%05d" % _score
#	audio_gema_perdida.play()
#	if _score < 0:
#		stop_all()

func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	label.text = "%05d" % _score
	audio_gema_capturada.play()
	area.queue_free()


func _on_parede_baixo_area_entered(area: Area2D) -> void:
	pass


func _on_parede_direita_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_parede_esquerda_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_parede_cima_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
