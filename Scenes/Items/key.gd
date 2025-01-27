extends InteractableObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact(player) -> void:
	if is_interactable:
		print(item_data.item_name + ": " + item_data.description)
		player.add_to_inventory(item_data)
		self.queue_free()
