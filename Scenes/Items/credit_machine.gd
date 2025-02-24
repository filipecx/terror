extends InteractableObject

@export var requested_item: ItemData = null
@export var tax: float = 5

func interact(player):
	if player.has_item(requested_item):
		if player.money >= tax:
			player.subtract_money(tax)
			player.add_credit()
		else:
			on_failed_interaction()
	else:
		on_failed_interaction()
