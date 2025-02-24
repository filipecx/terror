extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName


func _enter() -> void:
	if animation and animation_player:
		animation_player.play(animation)
	agent.speed = 0


func _ready() -> void:
	pass

func _update(delta: float) -> void:
	pass
