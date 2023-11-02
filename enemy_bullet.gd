extends Sprite2D

var velocity = Vector2(1, 0)
var speed = 250

var look_once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var nearest_player = Global.nearest_player_in_distance(global_position, 600)
	if look_once:
		velocity = global_position.direction_to(nearest_player.global_position)
		look_once = false
	global_position += velocity * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
