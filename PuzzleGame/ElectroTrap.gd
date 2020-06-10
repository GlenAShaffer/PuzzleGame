extends Area2D


func _on_ElectroTrap_body_entered(body):
	if body.get_groups().has("Player") :
		get_tree().call_group("Player", "die")
