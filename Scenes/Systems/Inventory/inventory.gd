extends Node

class_name Inventory

@export var max_slots: int = 10
@export var inventory_slot_scene: PackedScene
@onready var slots_ui: GridContainer = $InventoryWindow/SlotContainer

var slots: Array = []  # Each slot contains a Dictionary with "item_data" and "quantity"

func _ready() -> void:
	create_slots()

# Add an item to the inventory
func add_item(item_data: ItemData, quantity: int = 1) -> bool:
	for slot in slots:
		# Check if the item can stack
		if slot["item_data"] == item_data and item_data.stackable:
			slot["quantity"] += quantity
			update_slots_ui()
			return true

	# If no stackable slot found, add a new one
	if slots.size() < max_slots:
		slots.append({"item_data": item_data, "quantity": min(quantity, item_data.max_stack)})
		update_slots_ui()
		return true

	return false  # Inventory is full

# Remove an item from the inventory
func remove_item(item_data: ItemData, quantity: int = 1) -> bool:
	for slot in slots:
		if slot["item_data"] == item_data:
			slot["quantity"] -= quantity
			if slot["quantity"] <= 0:
				slots.erase(slot)  # Remove slot if quantity reaches zero
				return true
	return false  # Item not found

func get_item(item_data: ItemData) -> Dictionary:
	for slot in slots:
		if slot["item_data"] == item_data:
			return slot
	return {}

func has_item(item_data: ItemData) -> bool:
	return get_item(item_data) != {}

# Get all slots
func get_slots() -> Array:
	return slots

# Create slots in the GridContainer
func create_slots() -> void:

# Create `max_slots` slots using the InventorySlot scene
	for i in range(max_slots):
		var slot_instance = inventory_slot_scene.instantiate()
		slot_instance.name = "Slot_%d" % i
		slots_ui.add_child(slot_instance)

	update_slots_ui()

# Update the visual representation of slots
func update_slots_ui() -> void:
	for i in range(max_slots):
		var slot_instance = slots_ui.get_node("Slot_%d" % i)
		if i < slots.size():
			var slot_data = slots[i]
			slot_instance.set_item(slot_data["item_data"], slot_data["quantity"])
		else:
			slot_instance.set_empty()

# Slot button pressed callback
func _on_slot_pressed(slot_index: int) -> void:
	if slot_index < slots.size():
		var slot_data = slots[slot_index]
		print("Clicked on slot %d: %s x%d" % [slot_index, slot_data["item_data"].name, slot_data["quantity"]])
	else:
		print("Clicked on empty slot %d" % slot_index)
