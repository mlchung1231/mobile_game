extends Node2D

var enemy_1 = preload("res://enemy.tscn")
var item_gun_1 = preload("res://item_gun.tscn")

var time_sec = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.node_creation_parent = self


func _exit_stree():
	Global.node_creation_parent = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_enemy_spawn_timer_timeout():
	
	for i in range(Global.player_number):
		var enemy_position = random_point_inside_unit_circle()*Global.enemy_born_max_dis + Global.player[i].global_position
		var nearest_player = Global.nearest_player_in_distance(enemy_position, Global.enemy_born_max_dis)
		
		while enemy_position.distance_to(nearest_player.global_position)<Global.enemy_born_min_dis:
			enemy_position = random_point_inside_unit_circle()*Global.enemy_born_max_dis + Global.player[i].global_position
			
		Global.instance_node(enemy_1, enemy_position, self)


func _on_item_gun_timer_timeout():
	var item_gun_position = Vector2(randf_range(50,590), randf_range(30,330))
	
	Global.instance_node(item_gun_1, item_gun_position, self)
	
	

func random_point_inside_unit_circle():
	var random_vector = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	random_vector = random_vector.normalized()
	random_vector *= max(randf_range(0, 1), randf_range(0, 1))
	return random_vector


func _on_world_enemy_spawn_timer_timeout():
	var enemy_position = Vector2(randf_range(0,640),randf_range(0,360))
	
	while Global.nearest_player_in_distance(enemy_position, Global.enemy_born_max_dis) != null:
		enemy_position = Vector2(randf_range(0,640),randf_range(0,360))
		
	Global.instance_node(enemy_1, enemy_position, self)


func _on_world_day_timer_timeout():
	time_sec += 1
	if time_sec > 20:
		Global.daytime += 1
		time_sec = 1
	update_time(time_sec)
	
func update_time(time_sec):
	$World_day_timer/Daytimer.text = str(time_sec)
