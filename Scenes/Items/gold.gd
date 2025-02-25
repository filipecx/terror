extends InteractableObject

@export var money: float = 0.10
@onready var audio_player = $AudioStreamPlayer3D
func interact(player) -> void:
	if is_interactable:
		if (audio_player):
			audio_player.play()
		player.add_money(money)
		self.queue_free()
