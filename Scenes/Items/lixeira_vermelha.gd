extends InteractableObject
class_name Trash

@export var requested_item: ItemData = null
@export var reward_item: ItemData = null


func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	if not is_interactable:
		return

	if player.has_item(requested_item):
		if reward_item:
			player.add_to_inventory(reward_item)
		else:
			print("No reward item set for the trash")
	else:
		print("Player does not have the required item")
