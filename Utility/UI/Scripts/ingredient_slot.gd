extends TextureRect

@onready var ingredient = $Ingredient

var item = null

signal on_dropped_item(item:ItemBase)

func _can_drop_data(at_position, data):
	if item == null: return true
	return false

func _drop_data(at_position, data):
	ingredient.texture = data[0]
	item = data[1]
	on_dropped_item.emit(item)
