extends Area3D

var player: CharacterBody3D = null
@export var ray: RayCast3D = null

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _process(_delta: float):
	ray.force_raycast_update()

func is_player_visible():
	return player != null

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player.get_hitted(self.get_parent())

		# Not working yet
		# if ray.is_colliding():
		# 	if ray.get_collider() == body:
		# 		player = body

func _on_body_exited(body):
	if body == player:
		player.get_safe()
		player = null
