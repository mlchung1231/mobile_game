extends Node

var node_creation_parent = null
var player = [null,null,null,null,null,null,null,null]
var player1 = null
var player2 = null


var daytime = 1

var enemy_born_max_dis = 120
var enemy_born_min_dis = 50

func instance_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
