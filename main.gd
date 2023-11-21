extends Node2D

var enemy_1 = preload("res://enemy.tscn")
var enemy_2 = preload("res://enemy_2.tscn")
var enemy_3 = preload("res://enemy_3.tscn")
var item_gun_1 = preload("res://item_gun.tscn")
var item_armor_1 = preload("res://item_armor.tscn")

var time_sec = 1
var enemy2_timer = 0
var enemy3_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.node_creation_parent = self


func _exit_stree():
	Global.node_creation_parent = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# 玩家附近怪物生成
func _on_enemy_spawn_timer_timeout():
	# 所有玩家附近同時生怪，怪物仇恨目標為最近玩家 
	for i in range(Global.player_number):
		var enemy_position = random_point_inside_unit_circle()*Global.enemy_born_max_dis + Global.player[i].global_position
		var nearest_player = Global.nearest_player_in_distance(enemy_position, Global.enemy_born_max_dis)
		while enemy_position.distance_to(nearest_player.global_position)<Global.enemy_born_min_dis:
			enemy_position = random_point_inside_unit_circle()*Global.enemy_born_max_dis + Global.player[i].global_position
			
		Global.instance_node(enemy_1, enemy_position, self)

# 世界遊蕩怪物生成
func _on_world_enemy_spawn_timer_timeout():
	# 世界範圍內除玩家附近以外隨機生怪
	var enemy1_position = _enemy_born_position()
	Global.instance_node(enemy_1, enemy1_position, self)
	
	enemy2_timer += 1
	enemy3_timer += 1
	
	if Global.night == 1:
		if Global.day >= 3 and enemy2_timer >= 2:
			var enemy2_position = _enemy_born_position()
			Global.instance_node(enemy_2, enemy2_position, self)
			enemy2_timer = 0
		
		if Global.day >= 5 and enemy3_timer >= 4:
			var enemy3_position = _enemy_born_position()
			Global.instance_node(enemy_3, enemy3_position, self)
			enemy3_timer = 0
			
func _enemy_born_position():
	var enemy_position = Vector2(randf_range(0,640),randf_range(0,360))
	while Global.nearest_player_in_distance(enemy_position, Global.enemy_born_max_dis) != null:
		enemy_position = Vector2(randf_range(0,640),randf_range(0,360))
		
	return enemy_position

# 槍枝道具生成
func _on_item_gun_timer_timeout():
	var item_gun_position = Vector2(randf_range(50,590), randf_range(30,330))
	var item_armor_position = Vector2(randf_range(50,590), randf_range(30,330))
	
	Global.instance_node(item_gun_1, item_gun_position, self)
	Global.instance_node(item_armor_1, item_armor_position, self)

# 世界時間與天數
func _on_world_day_timer_timeout():
	time_sec += 1
	if time_sec > 20:
		Global.night = -Global.night
		time_sec = 1
		if Global.night == -1:
			Global.day += 1
		$World_day_timer/Day.text = "Day " + str(Global.day)
	update_time(time_sec)

func update_time(time_sec):
	$World_day_timer/Daytimer.text = str(time_sec)

# 單位園內隨機生成函數
func random_point_inside_unit_circle():
	var random_vector = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	random_vector = random_vector.normalized()
	random_vector *= max(randf_range(0, 1), randf_range(0, 1))
	return random_vector
