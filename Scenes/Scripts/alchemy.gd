extends Node

@onready var container = $Container
@onready var ingredients = $"Container/Ingredient Slots"
@onready var recipebook = $"Container/Recipe Book Popup"
@onready var animplayer = $AnimationPlayer

signal on_shop_button_pressed
signal on_update_inventory
signal on_combine
signal on_dropped_ingredient(item:ItemBase)
signal add_to_inventory(item:ItemBase, count:int)

func _ready():
	container.visible = false
	recipebook.visible = false
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
	if recipebook.visible: return
	var ingreds:Array[ItemBase] = []
	for child in ingredients.get_children():
		ingreds.append(child.item)
	var possibleResults = CombinationDatabase.get_valid_combinations({1:ingreds[0],2:ingreds[1],3:ingreds[2],4:ingreds[3]})
	if possibleResults.size() == 1: 
		add_to_inventory.emit(possibleResults[0].result,possibleResults[0].amount)
		for child in ingredients.get_children():
			child.item = null
			child.ingredient.texture_normal = null
		return

func on_dropped_item(item:ItemBase):
	on_dropped_ingredient.emit(item)

func on_undropped_item(item:ItemBase):
	add_to_inventory.emit(item,1)

func _on_recipe_book_button_pressed():
	if recipebook.visible: return
	recipebook.visible = true
	animplayer.play("open_recipe_book")
