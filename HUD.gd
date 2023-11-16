extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Virtual_Joystick.set_position(Vector2(Setting.moving_Hposition,Setting.moving_Vposition))
	$Shoot_button.set_position(Vector2(Setting.shooting_Hposition,Setting.shooting_Vposition))
	
