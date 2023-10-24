extends Sprite2D

var speed = 50

var velocity = Vector2()

var start_position 
var end_position 

var face = 0
var turn = Vector2(1,0)

var stun = false
var hp = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	await get_tree().create_timer(0.75).timeout
	
	velocity = turn
	
	if Global.player[0] != null and stun == false:
		if global_position.distance_to(Global.player[0].global_position)<Global.enemy_born_max_dis or Global.daytime % 2 == 0:
			velocity = global_position.direction_to(Global.player[0].global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
	
	global_position += velocity * speed * delta
	
	if hp <= 0:
		queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") and stun == false:
		modulate = Color.RED
		velocity = -velocity * 6
		hp -= 1
		stun = true
		$Hitbox/Stun_timer.start()
		area.get_parent().queue_free()
		
	if area.is_in_group("Touch_wall"):
		velocity = -velocity * 3


func _on_stun_timer_timeout():
	modulate = Color.WHITE
	stun = false


func _on_turn_timer_timeout():
	if face == 0:
		turn = Vector2(1,0)
	elif face == 1:
		turn = Vector2(0,1)
	elif face == 2:
		turn = Vector2(-1,0)
	elif face == 3:
		turn = Vector2(0,-1)
	face += 1
	if face >= 4:
		face = 0
