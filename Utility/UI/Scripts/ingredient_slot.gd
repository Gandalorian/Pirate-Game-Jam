extends TextureRect

@onready var ingredient = $Ingredient

var item = null

signal on_dropped_item(item:ItemBase)
signal on_undropped_item(item:ItemBase)

func _can_drop_data(at_position, data):
	if item == null: return true
	return false
	
func _on_ingredient_on_drop(data):
	ingredient.texture_normal = data[0]
	item = data[1]
	on_dropped_item.emit(item)

func _on_ingredient_pressed():
	if item == null: return
	on_undropped_item.emit(item)
	ingredient.texture_normal = null
	item = null
