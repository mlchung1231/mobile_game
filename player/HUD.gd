extends CanvasLayer

signal use_move_vector

var move_vector = Vector2(0,0)
var joystick_active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Joystick.set_position(Vector2(Setting.joystick_x,Setting.joystick_y))
	$Attack_button.set_position(Vector2(Setting.attack_x,Setting.attack_y))
	$Build_button.set_position(Vector2(Setting.build_x,Setting.build_y))
	$Bag_button.set_position(Vector2(Setting.bag_x,Setting.bag_y))
	
func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $Joystick.is_pressed():
			move_vector = calculate_move_vector(event.position)
			joystick_active = true
			var texture_center = $Joystick.position + Vector2(60,60)
			var range = event.position.distance_to(texture_center)
			if range > 60:
				var mark_position
				mark_position = calculate_move_vector(event.position) * 60 + $Joystick.position + Vector2(60,60)
				$Joystick_mark.position = mark_position
			else:
				$Joystick_mark.position = event.position
			
			
	if event is InputEventScreenTouch:
		if event.pressed == false:
			joystick_active = false
			

func _physics_process(delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
	else:
		emit_signal("use_move_vector", Vector2(0,0))
		$Joystick_mark.position = Vector2(Setting.joystick_x + 60,Setting.joystick_y + 60)

func calculate_move_vector(event_position):
	var texture_center = $Joystick.position + Vector2(60,60)
	return (event_position - texture_center).normalized()
	

func _on_setting_menu_pressed():
	$MainMenu.show()
	$Joystick.hide()
	$Joystick_mark.hide()
	$Attack_button.hide()
	$Bag_button.hide()
	$Build_button.hide()


func _on_main_menu_close_menu():
	$MainMenu.hide()
	$Joystick.show()
	$Joystick_mark.show()
	$Attack_button.show()
	$Bag_button.show()
	$Build_button.show()
