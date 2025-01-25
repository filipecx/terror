extends Node3D

@export var is_interactable: bool = true
@export var highlight_material: StandardMaterial3D

var original_material: Material

func _ready() -> void:
	# Save the original material for restoration
	if $MeshInstance3D.material_override:
		original_material = $MeshInstance3D.material_override
	else:
		print("Warning: No material_override found on:", name)

func highlight() -> void:
	# Apply highlight material if interactable and highlight_material is set
	if is_interactable and highlight_material:
		$MeshInstance3D.material_override = highlight_material

func reset_highlight() -> void:
	# Restore the original material
	if original_material:
		$MeshInstance3D.material_override = original_material
	else:
		$MeshInstance3D.material_override = null

func interact() -> void:
	if is_interactable:
		print("Interacted with:", name)
