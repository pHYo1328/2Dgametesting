extends Area2D




func _on_coin_body_entered(body):
	$AnimationPlayer1.play("bounce")
	body.addcoins()



func _on_AnimationPlayer1_animation_finished(anim_name):
	queue_free()
