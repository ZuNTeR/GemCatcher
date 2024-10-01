extends Node2D

@export var gem_scene: PackedScene
@export var time_gem_scene: PackedScene
@export var gemini_gem_scene: PackedScene
@onready var paddle: Area2D = $Paddle
@onready var double_paddle: Area2D = $DoublePaddle

@onready var label_time: Label = $Infos/LabelTime
@onready var tempo_jogo: Timer = $Infos/TempoJogo
@onready var label: Label = $Infos/Label
@onready var timer: Timer = $Infos/Timer
@onready var label_time_gem: Label = $Infos/LabelTimeGem
@onready var audio_gema_capturada: AudioStreamPlayer2D = $Sons/AudioGemaCapturada
@onready var audio_gema_perdida: AudioStreamPlayer2D = $Sons/AudioGemaPerdida
@onready var timer_velocidade: Timer = $Infos/TimerVelocidade
@export var base_speed = 100
@export var speed_increment = 50
@export var base_wait_time = 2.0
@export var min_wait_time = 0.1
@export var speed_scaling_factor = 0.1
var TimeGemLeft = 3 
var pontos = 0
var TimePlus = 0
var _score: int = 0

func _ready() -> void:
	spawn_gem()

	double_paddle.visible = false
	double_paddle.set_process(false)
	double_paddle.set_physics_process(false)
	#double_paddle.queue_free()

func _process(delta: float) -> void:
	var m = int (tempo_jogo.time_left) / 60
	var s = int (tempo_jogo.time_left) % 60
	label_time_gem.text = str (TimeGemLeft)
	if s < 10:
		label_time.text = "0" + str(m) + ":0" + str(s)
	else: 
		label_time.text = "0" + str(m) + ":" + str(s)
	if Input.is_action_just_pressed("z") and tempo_jogo.time_left < 270 and TimeGemLeft > 0:
		TimeGemLeft -= 1
		spawn_time_gem()
		
	if Input.is_action_just_pressed("x"):
		spawn_gemini_gem()

func spawn_gem() -> void:
	var new_gem = gem_scene.instantiate()
	if new_gem:
		if _on_timer_velocidade_timeout():
			TimePlus += 2.0
		new_gem.speed = TimePlus + base_speed + pontos * speed_scaling_factor * speed_increment
		var new_wait_time = base_wait_time - (pontos * 0.04)
		timer.wait_time = max(new_wait_time, min_wait_time)
	var xpos: float = randf_range(70, 1050)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)
	
func spawn_time_gem() -> void:
	var new_time_gem = time_gem_scene.instantiate()
	if new_time_gem:
		new_time_gem.speed = TimePlus + base_speed + pontos * speed_scaling_factor * speed_increment
		var new_wait_time = base_wait_time - (pontos * 0.04)
		timer.wait_time = max(new_wait_time, min_wait_time)
	var xpos: float = randf_range(70, 1050)
	new_time_gem.position = Vector2(xpos, -50)
	add_child(new_time_gem)
	
func spawn_gemini_gem() -> void:
	var new_gemini_gem = gemini_gem_scene.instantiate()
	if new_gemini_gem:
		new_gemini_gem.speed = TimePlus + base_speed + pontos * speed_scaling_factor * speed_increment
		var new_wait_time = base_wait_time - (pontos * 0.04)
		timer.wait_time = max(new_wait_time, min_wait_time)
	var xpos: float = randf_range(70, 1050)
	new_gemini_gem.position = Vector2(xpos, -50)
	add_child(new_gemini_gem)
	

func _on_timer_timeout() -> void:
	spawn_gem()
	
func lose_gem() -> void:
	_score -= 50
	pontos -= 1
	label.text = "%05d" % _score
	audio_gema_perdida.play()
	
func _on_gemini_gem_captured() -> void:
	paddle.visible = false
	paddle.set_process(false)
	paddle.set_physics_process(false)
	paddle.queue_free()
	double_paddle.visible = true
	double_paddle.set_process(true)
	double_paddle.set_physics_process(true)

func _on_paddle_area_entered(area: Area2D) -> void:
	if area is TimeGem:
		TimePlus = -60.0
		tempo_jogo.start(tempo_jogo.time_left + 30)
		audio_gema_capturada.play()
		area.queue_free()
	elif area is Gem:
		_score += 50
		pontos += 1
		label.text = "%05d" % _score
		audio_gema_capturada.play()
		area.queue_free()
	elif area is GeminiGem:
		_on_gemini_gem_captured()

func _on_parede_baixo_area_entered(area: Area2D) -> void:
	lose_gem()

func _on_timer_velocidade_timeout() -> bool:
	return true
	
func _on_double_paddle_area_entered(area: Area2D) -> void:
	if area is TimeGem:
		TimePlus = -60.0
		tempo_jogo.start(tempo_jogo.time_left + 30)
		audio_gema_capturada.play()
		area.queue_free()
	elif area is Gem:
		_score += 50
		pontos += 1
		label.text = "%05d" % _score
		audio_gema_capturada.play()
		area.queue_free()
