extends InteractableObject
class_name CollectableObject

func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	if is_interactable:
		player.add_to_inventory(item_data)
		self.queue_free()
