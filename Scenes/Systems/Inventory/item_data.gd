extends Resource

class_name ItemData

@export var item_name: String = ""
@export var description: String = ""
@export var category: ITEM_CATEGORY  = ITEM_CATEGORY.KEY
@export var stackable: bool = true
@export var max_stack: int = 99
@export var quantity: int = 1
@export var icon: Texture = null
@export var scene_path: String = ""

enum ITEM_CATEGORY {
	KEY,
	MISC,
	CONSUMABLE,
	OBJECTIVE,
}
