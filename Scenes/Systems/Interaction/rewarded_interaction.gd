extends Node
class_name RewardedInteraction

@export var requested_items: Array[ItemData] = []
@export var reward_items: Array[ItemData] = []

func _ready():
	var parent = get_parent()
	if parent is InteractableObject:
		parent.interacted.connect(_on_interacted)


func _on_interacted(interactor):
	if interactor.inventory and interactor.has_items(requested_items):
		_grant_reward(interactor)
	else:
		print("Missing required items:", requested_items)

func _grant_reward(interactor):
	for item in requested_items:
		interactor.remove_from_inventory(item)

	for item in reward_items:
		interactor.add_to_inventory(item)
		print("Reward granted:", item)
