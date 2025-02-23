extends Node3D
class_name InteractableObject

@export var is_interactable: bool = true
@export var should_consume: bool = true
@export var interact_text: String = "use"
@export var item_highlight_mesh: MeshInstance3D
@export var item_data: ItemData = null
@export var feedback_ui: FeedbackUI = null
@export var bad_interaction: String = "For some reason you can't"

signal interacted(interactor)


func _ready() -> void:
	pass

func highlight() -> void:
	item_highlight_mesh.visible = true

func reset_highlight() -> void:
	item_highlight_mesh.visible = false

func get_interact_text() -> String:
	return "Clique para " + interact_text;

func interact(player: CharacterBody3D) -> void:
	if is_interactable:
		on_success_interaction()
		interacted.emit(player)

func on_failed_interaction() -> void:
	if feedback_ui:
		feedback_ui.show_message(bad_interaction)

func on_success_interaction() -> void:
	if feedback_ui:
		if should_consume:
			feedback_ui.show_message("You've got " + item_data.item_name)
