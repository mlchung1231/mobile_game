extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Healthbar.value <= 30:
		$Healthbar.tint_progress = Color.RED
	elif $Healthbar.value <= 60:
		$Healthbar.tint_progress = Color.YELLOW
	else:
		$Healthbar.tint_progress = Color.GREEN
		
