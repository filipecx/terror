extends Node
class_name RewardedInteraction

@export var requested_items: Array[ItemData] = []
@export var reward_items: Array[ItemData] = []

func _ready():
	var parent = get_parent()
	if parent is InteractableObject:
		parent.interacted.connect(_on_interacted)


func _execute_failure_action():
	var parent = get_parent()
	if parent and parent.has_method("on_failed_interaction"):
		parent.on_failed_interaction()

func _execute_successful_action():
	var parent = get_parent()
	if parent and parent.has_method("on_successful_interaction"):
		parent.on_successful_interaction()

func _on_interacted(interactor):
	if interactor.inventory and interactor.has_items(requested_items):
		_grant_reward(interactor)
		_execute_successful_action()
	else:
		print("Missing required items:", requested_items)
		_execute_failure_action()

func _grant_reward(interactor):
	for item in requested_items:
		interactor.remove_from_inventory(item)

	for item in reward_items:
		interactor.add_to_inventory(item)
		print("Reward granted:", item)
