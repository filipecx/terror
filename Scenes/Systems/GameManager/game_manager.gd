extends Node

@onready var player = $Player
@onready var game_ui = $GameUi

@export var countdown_time: float = 300.0
@export var countdown_active: bool = true
@export var normal_speed: float = 1.0
@export var current_speed_multiplier: float = normal_speed
@export var lose_menu: NodePath

var lose_menu_node
var canvas: CanvasLayer


func _ready():
	lose_menu_node = get_node(lose_menu) if not lose_menu.is_empty() else null
	if lose_menu_node:
		lose_menu_node.hide()
	canvas = lose_menu_node.get_node("CanvasLayer")
	player.interaction_prompt.connect(game_ui.set_interaction_text)
	player.update_money.connect(game_ui.update_money)
	player.update_credit.connect(game_ui.update_credit)
	player.slime_hit.connect(on_player_hit)
	player.safe.connect(on_player_hit_leave)

func _process(delta: float):
	if countdown_active:
		countdown_time -= delta * current_speed_multiplier
		game_ui.update_timer(countdown_time)
		if countdown_time <= 0:
			countdown_active = false
			canvas.visible = true
			canvas.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			# get_tree().quit()

func on_player_hit(speed_multiplier: float):
	current_speed_multiplier = speed_multiplier

func on_player_hit_leave():
	current_speed_multiplier = normal_speed
