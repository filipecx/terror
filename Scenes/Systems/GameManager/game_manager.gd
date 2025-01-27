extends Node

@onready var player = $Player
@onready var game_ui = $GameUi

@export var countdown_time: float = 20.0
@export var countdown_active: bool = true


func _ready():
	player.interaction_prompt.connect(game_ui.set_interaction_text)

func _process(delta: float):
	if countdown_active:
		countdown_time -= delta
		game_ui.update_timer(countdown_time)
		if countdown_time <= 0:
			countdown_active = false
			print("Game Over!")
			get_tree().quit()
