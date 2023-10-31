extends Sprite2D

var speed = 50

var velocity = Vector2()

var face = 0
var turn = Vector2(1,0)

var stun = false
var hp = 3

var nearest_player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	await get_tree().create_timer(0.75).timeout
	
	velocity = turn
	
	if stun == false:
		if Global.daytime % 2 == 0:
			nearest_player = Global.nearest_player_in_distance(global_position, 600)
			velocity = global_position.direction_to(nearest_player.global_position)
		else:
			nearest_player = Global.nearest_player_in_distance(global_position, Global.enemy_born_max_dis)
			if nearest_player != null:
				velocity = global_position.direction_to(nearest_player.global_position)
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
	match face:
		0:
			turn = Vector2(1,0)
		1:
			turn = Vector2(0,1)
		2:
			turn = Vector2(-1,0)
		3:
			turn = Vector2(0,-1)
	face += 1
	if face >= 4:
		face = 0
