extends Node

@onready var container = $Container
@onready var ingredients = $"Container/Ingredient Slots"

signal on_shop_button_pressed
signal on_update_inventory
signal on_combine
signal on_dropped_ingredient(item:ItemBase)
signal add_to_inventory(item:ItemBase, count:int)

func _ready():
	container.visible = false
	for child in ingredients.get_children():
		child.on_undropped_item.connect(on_undropped_item)

func set_visible(visibility):
	container.visible = visibility
	if visibility:
		on_update_inventory.emit()

func _on_button_pressed():
	on_shop_button_pressed.emit()

func update_inventory(inventory):
	container.update_inventory(inventory)

func _on_combine_button_pressed():
	var possibleResults
	for child in ingredients.get_children():
		if child.item == null: continue
		
func on_dropped_item(item:ItemBase):
	on_dropped_ingredient.emit(item)

func on_undropped_item(item:ItemBase):
	add_to_inventory.emit(item,1)
