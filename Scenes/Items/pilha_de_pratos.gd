extends CollectableObject
class_name Plate

@onready var sound = $AudioStreamPlayer3D
var prato_scene = preload("res://Scenes/prato.tscn")


func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	super(player)
	var prato = prato_scene.instantiate()
	player.add_child(prato)
	prato.name = "prato"
	is_interactable = false
	var distancia = 0.6
	var frente = player.global_transform.basis.z.normalized()
	var posicao = player.global_transform.origin - (frente * distancia)
	posicao.y -= 0.5
	posicao.z += 0.2
	prato.global_transform.origin = posicao
	sound.play()
	print("Interagiu")
