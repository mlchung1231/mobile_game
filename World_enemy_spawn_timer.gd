extends Timer

var enemy_born_time = [null,5,3,2,1,0.5,0.25]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_change_wait_time()

func _change_wait_time():
	if Global.daytime % 2 == 1:
		self.wait_time = 5
	else:
		self.wait_time = enemy_born_time[Global.daytime/2]
