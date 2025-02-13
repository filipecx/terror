extends Node

@onready var player = $Player
@onready var game_ui = $GameUi

@export var countdown_time: float = 300.0
@export var countdown_active: bool = true


func _ready():
	player.interaction_prompt.connect(game_ui.set_interaction_text)
	player.update_money.connect(game_ui.update_money)
	player.update_credit.connect(game_ui.update_credit)

func _process(delta: float):
	if countdown_active:
		countdown_time -= delta
		game_ui.update_timer(countdown_time)
		if countdown_time <= 0:
			countdown_active = false
			print("Game Over!")
			get_tree().quit()
