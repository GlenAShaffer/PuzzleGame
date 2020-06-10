extends RigidBody2D

export var speed = 400
var sprint = 2
var musicPoint = 0
var flag = false
signal player_died

func _ready():
	$WalkingParticles.set_emitting(false)
	$Camera2D.make_current()
	$AudioStreamPlayer.play()
	musicPoint = $AudioStreamPlayer.get_playback_position()
	$AudioStreamPlayer.stop()
	
func _process(_delta):
	var velocity = Vector2() #The player's movement vector
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_sprint"):
		velocity = velocity.normalized() * speed * sprint
	elif Input.is_action_pressed("ui_slow"):
		velocity = velocity.normalized() * speed/2
	else:
		velocity = velocity.normalized() * speed
	
	if velocity.length() > 0:	
		$WalkingParticles.set_emitting(true)
		linear_velocity = velocity 
		if musicPoint >= 1:
			musicPoint = 0
			$AudioStreamPlayer.play(musicPoint)
		
		if flag != true:
			flag = true
			$AudioStreamPlayer.play(musicPoint)
	else:
		$WalkingParticles.set_emitting(false)
		musicPoint = $AudioStreamPlayer.get_playback_position()
		$AudioStreamPlayer.stop()
		flag = false



func die():
	print("Died...")
	speed = 0
	$DeathSound.play()
	#Wait for just a bit
	$Sprite.hide()
	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	emit_signal("player_died")
