extends StaticBody3D

@onready var door_mesh = $mesh
@onready var collision = $CollisionShape3D
@onready var audio_player = $AudioStreamPlayer3D
@export var move_distance: float = 5.0  # Distance to slide the door
@export var tween_duration: float = 1.5  # Duration of the sliding animation

func open_door() -> void:
	# Calculate the target position for the door
	print("Opening the door")
	var target_position = door_mesh.transform.origin + Vector3(0, 0, move_distance)
	if (audio_player):
		audio_player.play()
	# Create a new Transform3D with the updated position
	var new_transform = door_mesh.transform
	new_transform.origin = target_position

	# Create a Tween and animate the door
	var tween = create_tween()
	tween.tween_property(door_mesh, "transform:origin",target_position, tween_duration)

	# After the tween finishes, make the door invisible
	tween.finished.connect(hide_door)

func close_door() -> void:
	# Calculate the target position for the door
	print("Closing the door")
	var target_position = door_mesh.transform.origin + Vector3(0, 0, -move_distance)

	# Create a new Transform3D with the updated position
	var new_transform = door_mesh.transform
	new_transform.origin = target_position

	# Create a Tween and animate the door
	var tween = create_tween()
	tween.tween_property(door_mesh, "transform:origin",target_position, tween_duration)

	# After the tween finishes, make the door invisible
	tween.finished.connect(show_door)

func hide_door() -> void:
	door_mesh.visible = false
	collision.set_deferred("disabled", true)
func show_door() -> void:
	door_mesh.visible = true
	collision.set_deferred("disabled", false)
