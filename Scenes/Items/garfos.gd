extends CollectableObject
class_name Forks

@onready var sound = $AudioStreamPlayer3D
var garfo_scene = preload("res://Scenes/garfo.tscn")


func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	super(player)
	var garfo = garfo_scene.instantiate()
	player.add_child(garfo)
	var distancia = 0.6
	var frente = player.camera.global_transform.basis.z.normalized()
	var posicao = player.camera.global_transform.origin - (frente * distancia)
	posicao.x -= 0.5
	posicao.y -= 0.5
	garfo.global_transform.origin = posicao
	sound.play()
	print("Interagiu")
