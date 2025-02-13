extends InteractableObject

@export var money: float = 0.10

func interact(player) -> void:
	if is_interactable:
		player.add_money(money)
		self.queue_free()
