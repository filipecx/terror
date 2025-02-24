extends InteractableObject
class_name Trash

@export var requested_item: ItemData = null
@export var reward_item: ItemData = null


func _ready() -> void:
	pass

func on_failed_interaction() -> void:
	super()
