extends KinematicBody2D
var velocity= Vector2(0,0)
var coins = 0
var speed=200
var gravity=35
var jumpforce= -950
signal coins_collected
func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x= speed
		$Sprite.play("walk")
		$Sprite.flip_h= false
	
	elif Input.is_action_pressed("left"):
		velocity.x= -speed
		$Sprite.play("walk")
		$Sprite.flip_h=true
	
	else:
		$Sprite.play("idle")
	
	if not is_on_floor():
		$Sprite.play("air")
		velocity.y = velocity.y+gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpforce
	
	move_and_slide(velocity,Vector2.UP)
	velocity.x=lerp(velocity.x,0,0.15)
	if  coins==4:
		get_tree().change_scene("res://Finish Scene.tscn")


func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")

func addcoins():
	coins=coins+1
	emit_signal("coins_collected")
	
func bounce():
	velocity.y = jumpforce * 0.7
	
func ouch(var enemydirec):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = jumpforce * 0.5
	print(enemydirec)
	velocity.x = 800 * enemydirec
	
	
	Input.action_release("left")
	Input.action_release("right")
	


