extends Control

signal close_menu

var master_bus = AudioServer.get_bus_index("Master")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()
		
func toggle():
	visible = !visible

func show_and_hide(first, second):
	first.show()
	second.hide()
	
	
func _on_back_from_options_pressed():
	emit_signal("close_menu")
	
func _on_setting_pressed():
	show_and_hide($Setting, $Options)

func _on_back_from_setting_pressed():
	show_and_hide($Options, $Setting)


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)

#func _on_moving_vertical_value_changed(value):
#	Setting.moving_Vposition = 240 - value 

#func _on_moving_horizontal_value_changed(value):
#	Setting.moving_Hposition = 30 + value 

#func _on_shooting_vertical_value_changed(value):
#	Setting.shooting_Vposition = 270 - value 
#
#func _on_shooting_horizontal_value_changed(value):
#	Setting.shooting_Hposition = 550 + value 

func _on_adjustment_pressed():
	show_and_hide($Adjustment, $Options)


func _on_back_from_adj_pressed():
	show_and_hide($Options, $Adjustment)
