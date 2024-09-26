extends Node2D

@export var gem_scene: PackedScene
@onready var label: Label = $Infos/Label
@onready var timer: Timer = $Infos/Timer
@onready var audio_gema_capturada: AudioStreamPlayer2D = $Sons/AudioGemaCapturada
@onready var audio_gema_perdida: AudioStreamPlayer2D = $Sons/AudioGemaPerdida


const Paddle = "Paddle"
const Gem = "Gem"
const ParedeDireita = "ParedeDireita"
const ParedeEsquerda = "ParedeEsquerda"
signal on_gem_touch_under_bound

var _score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func spawn_gem() -> void:
	var new_gem = gem_scene.instantiate()
	
	if _score > 100:
		new_gem.speed += 100
	elif _score > 2000:
		new_gem.speed += 100
	elif _score > 300:
		new_gem.speed += 100
	
	var xpos: float = randf_range(70, 1050)
	#new_gem.on_gem_off_screen(lose_gem)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)

#func stop_all() -> void:
#	timer.stop()

func _on_timer_timeout() -> void:
	spawn_gem()
	
func lose_gem() -> void:
	_score -= 50
	label.text = "%05d" % _score
	
	audio_gema_perdida.play()
#	if _score < 0:
#		stop_all()

func _on_paddle_area_entered(area: Area2D) -> void:
	if area.name == ParedeDireita:
		pass
	elif area.name == ParedeEsquerda:
		pass
	else:
		_score += 50
		
		on_gem_touch_under_bound.emit()
		label.text = "%05d" % _score
		audio_gema_capturada.play()
		area.queue_free()
	

func _on_parede_baixo_area_entered(area: Area2D) -> void:
	 
	lose_gem()
	
	
	#await get_tree().create_timer(1.0).timeout
	
	#if area.name == Gem:
	#	lose_gem()
	#	print("Geeeeeeeemmmmmm")
		#on_gem_off_screen.emit()
		#await get_tree().create_timer(1.0).timeoutS
		
	

func _on_parede_direita_area_entered(area: Area2D) -> void:
	pass
		


func _on_parede_esquerda_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_parede_cima_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
