extends Node

export var winningScore = 1
var score = 0

signal endgame
signal reset

func _ready():
	$HUD/Panel/ScoreLabel.set_text(String(score) + "/" + String(winningScore))
	$HUD/ResetButton.connect("pressed", self, "send_reset_signal")
	$Character.connect("player_died", self, "send_reset_signal")
	print("Level loaded")


func update_score():
	score += 1
	$HUD/Panel/ScoreLabel.set_text(String(score) + "/" + String(winningScore))
	if score >= winningScore: #Stops music, plays the victory noise, waits 2, then stops victory noise and sends signal to game node
		$VictoryNoise.play()
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$VictoryNoise.stop()
		emit_signal("endgame")

func send_reset_signal():
	emit_signal("reset")
