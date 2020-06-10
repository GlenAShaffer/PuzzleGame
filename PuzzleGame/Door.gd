extends Area2D

var flag = false
signal hit

func _on_Door_body_entered(_body):
	if flag == false:
		$AudioStreamPlayer.play(0.2)
		$Sprite.hide()
		$CPUParticles2D.emitting = true
		emit_signal("hit")
		flag = true
