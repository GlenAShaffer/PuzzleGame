extends CanvasLayer

signal start_game

func _ready():
	$StartContainer/Button.connect("pressed", self, "start_button_press")

func start_button_press():
	emit_signal("start_game")
