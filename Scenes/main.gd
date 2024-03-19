extends Node

var vDireccion = Vector2(1,0)
var lV2PositionMemory = []
var lSnake = []
var anchoCuad: int = 32
var ndPieza

func _ready() -> void:
	lSnake = $"Snake".get_children()
	ndPieza = preload("res://Scenes/BP_Snake.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Go←") == true:
		vDireccion = Vector2(-1,0)
	elif Input.is_action_just_pressed("Go→") == true:
		vDireccion = Vector2(1,0)
	elif Input.is_action_just_pressed("Go↑") == true:
		vDireccion = Vector2(0,-1)
	elif Input.is_action_just_pressed("Go↓") == true:
		vDireccion = Vector2(0,1)

func _on_timer_timeout() -> void:
	lSnake = $"Snake".get_children()
	
	#memorizar posiciones de las piezas del snake
	for snake in lSnake:
		lV2PositionMemory.append(snake.position)

	#eliminar la cola
	lV2PositionMemory.pop_back()
	
	#calcular nueva posicion de la cabeza
	lSnake[0].position += anchoCuad * vDireccion
	#meter en la cabeza nueva posicion
	lV2PositionMemory.insert(0, lSnake[0].position)
	
	#actualizar posiciones
	for i in range(lSnake.size()):
		lSnake[i].position = lV2PositionMemory[i]

func _on_comida_area_entered(area: Area2D) -> void:
	print("ha habido colision con la comida en " + str($"Comida".position))
	$"Comida".position = anchoCuad * Vector2(randi()%20, randi()%12)
	$"Snake".add_child(ndPieza.instantiate())
