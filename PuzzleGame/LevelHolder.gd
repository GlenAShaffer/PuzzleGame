extends Node

export var levelNum = 0
export var totLevelNum = 1

func _ready():
	$StartMenu.connect("start_game", self, "begin_level")
	$AudioStreamPlayer.play()

func begin_level(): #Hides The Start menu and loads in the level
	print("began game")
	var next_level_resource = load("res://Levels/Level"+String(levelNum)+".tscn")
	var next_level = next_level_resource.instance()
	self.add_child(next_level)
	$Level.connect("endgame", self, "end_level")
	$Level.connect("reset", self, "reset_level")
	get_tree().call_group("startmenu", "hide")

func end_level(): #Removes the level and shows the start menu
	levelNum += 1
	var level = self.get_node("Level")
	self.remove_child(level)
	level.call_deferred("free")
	if levelNum < totLevelNum:
		begin_level()
	else:
		get_tree().call_group("startmenu", "show")
		levelNum = 0

func reset_level():
	var level = self.get_node("Level")
	self.remove_child(level)
	level.call_deferred("free")
	begin_level()
