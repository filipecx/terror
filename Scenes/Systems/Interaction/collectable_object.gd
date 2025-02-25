extends InteractableObject
class_name CollectableObject
@onready var sound_player = $AudioStreamPlayer3D
func _ready() -> void:
	pass

func interact(player: CharacterBody3D) -> void:
	if (sound_player):
			sound_player.play()
	if is_interactable:
		
		player.add_to_inventory(item_data)		
		if should_consume:
			self.queue_free();
