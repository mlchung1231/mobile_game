extends Sprite2D

var speed = 200
var velocity = Vector2()

var bullet = preload("res://bullet.tscn")
var wall = preload("res://wall.tscn")

var have_gun = false
var can_shoot = false
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# 上傳此玩家至Global(通用資料庫)
	Global.player[0] = self

func _exit_tree():
	Global.player[0] = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# 玩家移動
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	velocity = velocity.normalized()
	
	if is_dead == false:
		global_position += speed * velocity * delta
	
	# 左鍵射擊
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start()
		can_shoot = false
	
	# 空格放置牆體(暫停開發)
	if Input.is_action_pressed("put"):
		Global.instance_node(wall, global_position, Global.node_creation_parent)


func _on_reload_speed_timeout():
	can_shoot = true

# 玩家碰撞箱判定
func _on_hitbox_area_entered(area):
	# 玩家受擊
#	if area.is_in_group("Enemy"):
#		is_dead == true
#		visible = false
#		await(get_tree().create_timer(0.5).timeout)
#		get_tree().reload_current_scene()
		
	# 玩家撿取槍枝道具
	if area.is_in_group("Gun_pick_up") and is_dead == false:
		have_gun = true
		can_shoot = true
		
	# 玩家撞牆(暫停開發)
	if area.is_in_group("Touch_wall"):
		velocity = -velocity * 10
		
