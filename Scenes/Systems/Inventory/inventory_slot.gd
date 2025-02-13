extends Button

@onready var icon_texture: TextureRect = $Icon
@onready var quantity_label: Label = $Label
# @onready var description: Label = $

func set_item(item_data: ItemData, quantity: int):
	icon_texture.texture = item_data.icon
	if quantity > 1:
		quantity_label.text = str(quantity)

func set_empty():
	pass
	# icon_texture.texture = null
	# quantity_label.text = ""
