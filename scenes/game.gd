extends Node2D

@export var gem_scene: PackedScene
@export var time_gem_scene: PackedScene
@export var gemini_gem_scene: PackedScene
@export var ricochet_gem_scene: PackedScene

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

var movimentoy = Vector2()
var movimentox = Vector2()
var movimentoxV = 0
var movimentoyV = 0

var velocidade = Vector2(150, 150)
var max_velocidade = 300

var ricochet2 = 0
var ricochet3 = 0
var ricochet1 = 0
var new_ricochet_gem
var TimeGemLeft = 3 
var pontos = 0
var TimePlus = 0
var _score: int = 0
var _scoreRicochet: int = 50
var ricochetCaptureX = 0
var ricochetCaptureV = 150
var stored_delta: float = 0.0
var numeroRicochets = 0
var ricochet = false
var ricochetspawn = false
var lado = randi_range(1, 2)
var tempospawnricochet = 0
var paddleRicochet = 0
var ladoricochety = 0
var ladoricochetx = 0


func _ready() -> void:
	spawn_gem()
	double_paddle.position.x = 10000
	double_paddle.visible = false
	double_paddle.set_process(false)
	double_paddle.set_physics_process(false)

func _process(delta: float) -> void:
	var movimento = Vector2()
#	if RicochetGem == true:
#		_score += 50
#		pontos += 1
#		label.text = "%05d" % _score
#		audio_gema_capturada.play()
#		gem_scene.queue_free()
	
	
	if is_instance_valid(new_ricochet_gem):
		if new_ricochet_gem.position.y > get_viewport_rect().size.y + 25.0:
			new_ricochet_gem = null
	stored_delta = delta
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
		
	if Input.is_action_just_pressed("c"):
		spawn_ricochet_gem()
		await get_tree().create_timer(4.0).timeout
		tempospawnricochet = 1

	if ricochetspawn == true:
		if ricochet == false and is_instance_valid(new_ricochet_gem):
			movimento.y += 1
			movimento = movimento.normalized()
			new_ricochet_gem.position += movimento * velocidade * delta
		elif ricochet == true:
			ricochet_gem()

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

func spawn_ricochet_gem() -> void:
	new_ricochet_gem = ricochet_gem_scene.instantiate()
	new_ricochet_gem.connect("area_entered", Callable(self, "_on_area_entered"))
	ricochetspawn = true
	if new_ricochet_gem:
		new_ricochet_gem.speed = TimePlus + base_speed + pontos * speed_scaling_factor * speed_increment
		var new_wait_time = base_wait_time - (pontos * 0.04)
		timer.wait_time = max(new_wait_time, min_wait_time)
	var xpos: float = randf_range(-30, 1000)
	new_ricochet_gem.position = Vector2(xpos, -150)
	add_child(new_ricochet_gem)

func lose_gem() -> void:
	_score -= 50
	pontos -= 1
	label.text = "%05d" % _score
	audio_gema_perdida.play()

func _on_gemini_gem_captured() -> void:
	var paddlePosition = paddle.position.x
	
	paddle.visible = false
	paddle.set_process(false)
	paddle.set_physics_process(false)
	paddle.queue_free()
	double_paddle.sprite_left.position.x
	double_paddle.position.x = paddlePosition
	double_paddle.visible = true
	double_paddle.set_process(true)
	double_paddle.set_physics_process(true)

func ricochet_gem() -> void:
	if numeroRicochets == 0 and is_instance_valid(new_ricochet_gem):
		paddleRicochet = 1
		var movimentoy = Vector2()
		var movimentox = Vector2()
		movimentox.x = -1 if lado == 1 else 1
		movimentoxV = -1 if lado == 1 else 1 
		movimentoy.y = -1
		movimentoyV = -1
		
		movimentoy = movimentoy.normalized()
		movimentox = movimentox.normalized()
		new_ricochet_gem.position += movimentoy * velocidade * stored_delta
		new_ricochet_gem.position += movimentox * velocidade * stored_delta
		
	if numeroRicochets == 2 and is_instance_valid(new_ricochet_gem):
		var movimentoy = Vector2()
		var movimentox = Vector2()
		
		movimentox.x = 1 if ladoricochetx == 1 else -1 
		movimentoy.y = 1 if ladoricochety == 1 else -1
		
		movimentoxV = 1 if ladoricochetx == 1 else -1 
		movimentoyV = 1 if ladoricochety == 1 else -1
		

		movimentoy = movimentoy.normalized()
		movimentox = movimentox.normalized()
		new_ricochet_gem.position += movimentoy * velocidade * stored_delta
		new_ricochet_gem.position += movimentox * velocidade * stored_delta
		
	if numeroRicochets == 3 and is_instance_valid(new_ricochet_gem):
		var movimentoy = Vector2()
		var movimentox = Vector2()
		
		movimentox.x = 1 if ladoricochetx == 1 else -1
		movimentoy.y = 1
		movimentoyV = 1
		
		movimentoy = movimentoy.normalized()
		movimentox = movimentox.normalized()
		new_ricochet_gem.position += movimentoy * velocidade * stored_delta
		new_ricochet_gem.position += movimentox * velocidade * stored_delta
		
	if numeroRicochets == 1 and paddleRicochet == 1 and is_instance_valid(new_ricochet_gem):
		var movimentoy = Vector2()
		var movimentox = Vector2()
		
		movimentox.x = 1 if ladoricochetx == 1 else -1
		movimentoy.y = -1
		movimentoyV = -1
		
		movimentoy = movimentoy.normalized()
		movimentox = movimentox.normalized()
		new_ricochet_gem.position += movimentoy * velocidade * stored_delta
		new_ricochet_gem.position += movimentox * velocidade * stored_delta

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
		audio_gema_capturada.play()
		area.queue_free()
	elif area is RicochetGem:
		if Input.is_action_pressed("up"):
			ricochet1 = 1
			ricochet2 = 0
			ricochet3 = 0
			
			ladoricochetx = 1 if movimentoxV == 1 else 0
			
			ricochet = true
			if paddleRicochet == 1:
				numeroRicochets = 1
		else:
			if ricochetCaptureX == 0:
				_score += _scoreRicochet
				pontos += 1
			else:
				_score += _scoreRicochet * ricochetCaptureX
				pontos += 1 * ricochetCaptureX
			label.text = "%05d" % _score
			audio_gema_capturada.play()
			new_ricochet_gem = null
			area.queue_free()

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
	elif area is RicochetGem:
		if Input.is_action_pressed("up"):
			ricochet1 = 1
			ricochet2 = 0
			ricochet3 = 0
			
			ladoricochetx = 1 if movimentoxV == 1 else 0
			
			ricochet = true
			if paddleRicochet == 1:
				numeroRicochets = 1
		else:
			_score += _scoreRicochet
			label.text = "%05d" % _score
			audio_gema_capturada.play()
			new_ricochet_gem = null
			area.queue_free()

func _on_parede_direita_area_entered(area: Area2D) -> void:
	if area is RicochetGem:
		numeroRicochets = 2 
		ricochet1 = 0
		ricochet2 = 1
		ricochet3 = 0
		#ladoricochety = 1 if movimentox.x >= 1 else 0
		
		ladoricochetx = -1
		ladoricochety = 1 if movimentoyV == 1 else -1
func _on_parede_esquerda_area_entered(area: Area2D) -> void:
	if area is RicochetGem:
		numeroRicochets = 2 
		ricochet1 = 0
		ricochet2 = 1
		ricochet3 = 0
		#	ladoricochety = 1 if movimentox.x >= 1 else 0
	
		ladoricochetx = 1
		ladoricochety = 1 if movimentoyV == 1 else -1

func _on_parede_cima_area_entered(area: Area2D) -> void:
	if tempospawnricochet == 1:
		if area is RicochetGem:
			numeroRicochets = 3
			ricochet1 = 0
			ricochet2 = 0
			ricochet3 = 1
		#	ladoricochety = 1 if movimentoy.y <= 1 else 0
			ladoricochetx = 1 if movimentoxV == 1 else -1

func _on_parede_baixo_area_entered(area: Area2D) -> void:
	lose_gem()
	#new_ricochet_gem.set_process(false)
	#new_ricochet_gem.queue_free()
	#new_ricochet_gem = null

func _on_area_entered(area: Area2D) -> void:
	if area is Gem:
		ricochetCaptureX += 1
		ricochetCaptureV += 50
		velocidade = Vector2(ricochetCaptureV, ricochetCaptureV)
		audio_gema_capturada.play()
		area.queue_free()
	
func _on_timer_velocidade_timeout() -> bool:
	return true		

func _on_timer_timeout() -> void:
	spawn_gem()
		
		
		
		
		
		
		
		
