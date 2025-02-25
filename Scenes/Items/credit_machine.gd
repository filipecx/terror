extends InteractableObject

@export var requested_item: ItemData = null
@export var tax: float = 5
@onready var sound_player = $AudioStreamPlayer3D
func interact(player):
	if player.has_item(requested_item):
		if player.money >= tax:
			sound_player.play()
			player.subtract_money(tax)
			player.add_credit()
		else:
			on_failed_interaction()
	else:
		on_failed_interaction()
