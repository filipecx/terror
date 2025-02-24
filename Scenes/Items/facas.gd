extends CollectableObject
class_name Knives
@onready var sound = $AudioStreamPlayer3D
var faca_scene = preload("res://Scenes/faca.tscn")

func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	super(player)
	var faca = faca_scene.instantiate()
	player.add_child(faca)
	faca.name = "faca"
	is_interactable = false
	var distancia = 1.4
	var frente = player.global_transform.basis.z.normalized()
	var posicao = player.global_transform.origin - (frente * distancia)
	posicao.x += 0.5
	posicao.y -= 0.15
	faca.global_transform.origin = posicao
	sound.play()
	print("Interagiu")
