extends Sprite2D

@onready var falling_key = preload("res://objects/falling_key.tscn")
@onready var score_text = preload("res://objects/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = [] # Uma queue pra segurar as notas (falling keys) pra cada alvo (key listener)

# Se a distance_from_pass for menos que o threshold, dê essa pontuação
var perfect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80
# Senão, miss

var perfect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Garanta que tenha uma falling key (nota) pra checar essa nota
	if falling_key_queue.size() > 0:
		
		# Se a falling key (nota) passou, remove da queue
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			
			# print MISS
			var st_inst = score_text.instantiate() # Instância do texto de score
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo("MISS")
			st_inst.global_position = global_position + Vector2(-80, -15)
			
		# Se a nota foi pressionada, tira (pop) da queue e calcula a distância do ponto crítico
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			
			var press_score_text: String = ""
			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score); print("perfect")
				press_score_text = "PERFECT"
			elif distance_from_pass < great_press_threshold:
				Signals.IncrementScore.emit(great_press_score); print("great")
				press_score_text = "GREAT"
			elif distance_from_pass < good_press_threshold:
				Signals.IncrementScore.emit(good_press_score); print("good")
				press_score_text = "GOOD"
			elif distance_from_pass < ok_press_threshold:
				Signals.IncrementScore.emit(ok_press_score); print("ok")
				press_score_text = "OK"
			else:
				press_score_text = "MISS"
				pass
			
			key_to_pop.queue_free()
	
			var st_inst = score_text.instantiate() # Instância do texto de score
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo(press_score_text)
			st_inst.global_position = global_position + Vector2(-80, -15)
			
			
	

func CreateFallingKey(): # Instanciar a cena FallingKey do script key_listener.gd e diz ao KL onde a nota começa
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, frame + 4) # "frame + 4" porque têm 4 textures em cada linha e a FK desejada tá na próxima linha
	
	falling_key_queue.push_back(fk_inst)


func _on_random_spawn_timer_timeout():
	CreateFallingKey()
	$RandomSpawnTimer.wait_time = randf_range(0.4, 3)
	$RandomSpawnTimer.start()
