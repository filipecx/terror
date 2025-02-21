extends "res://Scenes/Systems/Interaction/interactable_object.gd"
class_name Ratchet

@export var required_credits: int = 1
@onready var collision_shape = $CollisionShape3D
@onready var no_jump_zone = $NoJumpZone
@onready var tresspass_zone = $TresspassZone
@onready var entrance_light = $OmniLight3D

# Define a signal to open the door
signal door_open_signal

func _ready() -> void:
	if collision_shape:
		collision_shape.disabled = false

	# Connect signals for Area3D
	no_jump_zone.body_entered.connect(on_body_entered)
	no_jump_zone.body_exited.connect(on_body_exited)

	tresspass_zone.body_entered.connect(on_tresspass_entered)
	tresspass_zone.body_exited.connect(on_tresspass_exited)

func interact(player: CharacterBody3D) -> void:
	if not is_interactable:
		return

	if player.credit >= required_credits:
		player.subtract_credit(required_credits)
		entrance_light.light_color = Color(0, 1, 0)
		print("Interacted with:", item_data.item_name)

		if collision_shape:
			collision_shape.set_deferred("disabled", true)


		emit_signal("door_open_signal")

		# Optional: Play a sound or animation for feedback
	else:
		print("Not enough credits to use the ratchet: ", required_credits)
		print("Player credit", player.credit)

# Triggered when a body enters the no jump zone
func on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.set_meta("can_jump", false)
		print("Jumping disabled for", body.name)

# Triggered when a body exits the no jump zone
func on_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.set_meta("can_jump", true)
		print("Jumping enabled for", body.name)

# Triggered when a body enters the tresspass zone
func on_tresspass_entered(body: Node3D) -> void:
	$AudioStreamPlayer3D.play()

# Triggered when a body exits the tresspass jump zone
func on_tresspass_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		entrance_light.light_color = Color(1, 0, 0)

		if collision_shape:
			collision_shape.set_deferred("disabled", false)
