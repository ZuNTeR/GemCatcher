extends Node2D

@export var gem_scene: PackedScene
@onready var label_time: Label = $Infos/LabelTime
@onready var tempo_jogo: Timer = $Infos/TempoJogo
@onready var label: Label = $Infos/Label
@onready var timer: Timer = $Infos/Timer
@onready var audio_gema_capturada: AudioStreamPlayer2D = $Sons/AudioGemaCapturada
@onready var audio_gema_perdida: AudioStreamPlayer2D = $Sons/AudioGemaPerdida
@export var base_speed = 100
@export var speed_increment = 50
@export var base_wait_time = 2.0
@export var min_wait_time = 0.1
@export var speed_scaling_factor = 0.1
var pontos = 0
const Gem = "Gem"
const Gem2 = "Gem2"
const Gem3 = "Gem3"
const Gem4 = "Gem4"
const Gem5 = "Gem5"
const Gem6 = "Gem6"
const Gem7 = "Gem7"
const Gem8 = "Gem8"
const Gem9 = "Gem9"
const Gem10 = "Gem10"
const ParedeDireita = "ParedeDireita"
const ParedeEsquerda = "ParedeEsquerda"
signal on_gem_touch_under_bound
var _score: int = 0

func _ready() -> void:
	spawn_gem()
	

func _process(delta: float) -> void:
	
	var m = int (tempo_jogo.time_left) / 60
	var s = int (tempo_jogo.time_left) % 60
	if s < 10:
		label_time.text = "0" + str(m) + ":0" + str(s)
	else: 
		label_time.text = "0" + str(m) + ":" + str(s)

func spawn_gem() -> void:
	var new_gem = gem_scene.instantiate()
	
	if new_gem:
		if _on_timer_velocidade_timeout() == true:
			new_gem.speed = 1000
			print("ola bbbb")
		new_gem.speed = base_speed + pontos * speed_scaling_factor * speed_increment
		var new_wait_time = base_wait_time - (pontos * 0.04)
		timer.wait_time = max(new_wait_time, min_wait_time)
	var xpos: float = randf_range(70, 1050)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)

func _on_timer_timeout() -> void:
	spawn_gem()
	
func lose_gem() -> void:
	_score -= 50
	pontos -= 1
	label.text = "%05d" % _score
	audio_gema_perdida.play()

func _on_paddle_area_entered(area: Area2D) -> void:
	if area.name == Gem or Gem2 or Gem3 or Gem4 or Gem5 or Gem6 or Gem7 or Gem8 or Gem9 or Gem10:
		_score += 50
		pontos += 1
		on_gem_touch_under_bound.emit()
		label.text = "%05d" % _score
		audio_gema_capturada.play()
		area.queue_free()

func _on_parede_baixo_area_entered(area: Area2D) -> void:
	lose_gem()
	
	
	
	


func _on_timer_velocidade_timeout() -> bool:
	return true
