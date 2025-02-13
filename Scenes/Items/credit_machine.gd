extends InteractableObject

@export var requested_item: ItemData = null
@export var tax: float = 5

func interact(player):
	if player.has_item(requested_item):
		if player.money >= tax:
			player.subtract_money(tax)
			player.add_credit()
		else:
			print("Not enough money")
	else:
		print("Player does not have the required item")
