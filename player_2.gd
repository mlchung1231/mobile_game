extends Sprite2D

var speed = 200
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player[1] = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = int(Input.is_action_pressed("p2_right")) - int(Input.is_action_pressed("p2_left")) 
	velocity.y = int(Input.is_action_pressed("p2_down")) - int(Input.is_action_pressed("p2_up"))
	
	velocity = velocity.normalized()
	
	global_position += speed * velocity * delta
	
