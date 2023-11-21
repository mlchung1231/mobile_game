extends Node

var node_creation_parent = null

var player_number = 2
var player = [null,null,null,null,null,null,null,null]

var day = 1
var night = -1

var enemy_born_max_dis = 120
var enemy_born_min_dis = 50

# 新增節點(子彈，怪物，牆體等)
func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
	
# 指定範圍內最近的玩家
func nearest_player_in_distance(enemy_position, distance):
	var nearest_distance
	var nearest_player
	nearest_distance = enemy_position.distance_to(Global.player[0].global_position)
	nearest_player = Global.player[0]
	for i in range(Global.player_number):
		if enemy_position.distance_to(Global.player[i].global_position) < nearest_distance:
			nearest_distance = enemy_position.distance_to(Global.player[i].global_position)
			nearest_player = Global.player[i]
			
	if nearest_distance > distance:
		return null
	else:
		return nearest_player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
