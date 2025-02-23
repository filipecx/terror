extends Area3D

@export var win_menu: NodePath
@export var player: NodePath

var win_menu_node
var canvas: CanvasLayer

func _ready():
	win_menu_node = get_node(win_menu) if not win_menu.is_empty() else null
	if win_menu_node:
		win_menu_node.hide()
	canvas = win_menu_node.get_node("CanvasLayer")
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Player entered")
		show_win_menu()

func show_win_menu():
	if win_menu_node:
		win_menu_node.show()
		canvas.visible = true
		canvas.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	get_tree().quit()
