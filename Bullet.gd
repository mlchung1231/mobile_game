extends Sprite2D

var velocity = Vector2(1, 0)

var speed = 250

var look_once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if look_once:
		#look_at(get_global_mouse_position())
		velocity = Global.player[0].velocity
		if velocity == Vector2(0,0):
			velocity = Global.player[0].temp_velocity
		look_once = false
	global_position += velocity	.rotated(rotation) * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
