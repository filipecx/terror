extends CollectableObject
class_name Bandejas1

@onready var sound = $AudioStreamPlayer3D
var bandeja_scene = preload("res://Scenes/bandeja.tscn")
func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	super(player)
	var bandeja = bandeja_scene.instantiate()
	player.add_child(bandeja)
	bandeja.name = "bandeja"
	is_interactable = false
	var distancia = 1.0
	var frente = player.global_transform.basis.z.normalized()
	var posicao = player.global_transform.origin - (frente * distancia)

	posicao.y -= 0.4
	bandeja.global_transform.origin = posicao
	sound.play()
