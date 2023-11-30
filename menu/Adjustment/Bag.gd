extends Sprite2D

var newDeltaX
var newDeltaY
var deltaX
var deltaY
var touchPos = Vector2()
var areaEnt = false
 
func _ready():
	set_position(Vector2(Setting.bag_x, Setting.bag_y))

func _on_touch_screen_button_pressed():
	areaEnt = true

func _on_touch_screen_button_released():
	areaEnt = false
	
func _input(event):
	if areaEnt == true:
		if event is InputEventScreenTouch and event.is_pressed():
			touchPos = event.get_position()
			deltaX = touchPos.x - position.x
			deltaY = touchPos.y - position.y
			
		elif  event is InputEventScreenDrag:
			touchPos = event.get_position()
			newDeltaX = touchPos.x - deltaX
			newDeltaY = touchPos.y - deltaY
			set_position(Vector2(newDeltaX, newDeltaY))
			Setting.bag_x = newDeltaX
			Setting.bag_y = newDeltaY
