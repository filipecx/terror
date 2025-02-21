extends InteractableObject
class_name CollectableObject

func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	if is_interactable:
		player.add_to_inventory(item_data)
		if should_consume:
			self.queue_free();
