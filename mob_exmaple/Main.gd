extends Node


export(PackedScene) var mob_scene
var score

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_MobTimer_timeout():
	# Создаем сцену (моба)
	var mob = mob_scene.instance()
	
	# Выбираем его положение на основе ранее заданного маршрута точек
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	# Выбираем направление движения перпендикулярно 
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	# Немного рандома к направлению
	direction += rand_range(-PI / 4 , PI / 4)
	mob.rotation = direction
	
	# Скорость моба + поворот вектора скорости в соответствии с направлением
	var velocity = Vector2(rand_range(125.0, 275.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Добавляем моба на сцену
	add_child(mob)


func _on_ScoreTimer_timeout():
	score += 1


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
