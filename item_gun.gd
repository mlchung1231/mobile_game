extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# 槍枝被玩家撿到
func _on_area_2d_area_entered(area):
	if area.is_in_group("Pick_up"):
		queue_free()
