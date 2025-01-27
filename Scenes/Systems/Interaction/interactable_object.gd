extends Node3D
class_name InteractableObject

@export var is_interactable: bool = true
@export var interact_text: String = "use"
@export var item_highlight_mesh: MeshInstance3D
@export var item_data: ItemData = null


func _ready() -> void:
	pass

func highlight() -> void:
	item_highlight_mesh.visible = true

func reset_highlight() -> void:
	item_highlight_mesh.visible = false

func get_interact_text() -> String:
	return "Press to " + interact_text;

func interact(player: CharacterBody3D) -> void:
	if is_interactable:
		print("Interacted with:", item_data.item_name)
		self.queue_free();
