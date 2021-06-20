extends KinematicBody2D
var speed = 50
var velocity = Vector2()
export var direction = -1
export var detect_cliff= true
func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h=true
	$floor_checker.position.x= $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detect_cliff
	
func _physics_process(delta):
	if is_on_wall() or not $floor_checker.is_colliding() and is_on_floor() and detect_cliff:
		direction = direction * -1
		$AnimatedSprite.flip_h= not $AnimatedSprite.flip_h
		$floor_checker.position.x= $CollisionShape2D.shape.get_extents().x * direction
		print(velocity.x)
	if not is_on_floor():
		velocity.y+=20
	
	velocity.x = speed * direction
	velocity = (move_and_slide(velocity,Vector2.UP))


func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("squarshed")
	speed = 0
	set_collision_layer_bit(4,false)
	set_collision_mask_bit(0,false)
	$top_checker.set_collision_layer_bit(4,false)
	$top_checker.set_collision_mask_bit(0,false)
	$side_checker.set_collision_layer_bit(4,false)
	$side_checker.set_collision_mask_bit(0,false)
	$Timer.start()
	body.bounce()


func _on_Timer_timeout():
	queue_free()
	


func _on_side_checker_body_entered(body):
	if $top_checker.overlaps_body(body):
		return 
	else : body.ouch(direction)
