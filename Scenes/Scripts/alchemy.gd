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
	
	# Get all placed ingredients
	var ingreds:Array[ItemBase] = []
	for child in ingredients.get_children():
		if child.item: ingreds.append(child.item)
	
	# If no ingredients placed, return
	if ingreds.size() < 1: return
	
	var combo_and_extra = CombinationDatabase.get_combination(ingreds)
	if combo_and_extra.has("combo"):
		do_combination(combo_and_extra["combo"],combo_and_extra["extra"])

func on_dropped_item(item:ItemBase):
	on_dropped_ingredient.emit(item)

func on_undropped_item(item:ItemBase):
	add_to_inventory.emit(item,1)

func _on_recipe_book_button_pressed():
	if recipebook.visible: return
	recipebook.visible = true
	animplayer.play("open_recipe_book")

func do_combination(combo, extra = 0):
	add_to_inventory.emit(combo.result,combo.amount + extra)
	for child in ingredients.get_children():
		child.item = null
		child.ingredient.texture_normal = null

func find_prio(array)-> int:
	var prio = 0
	var index = 0
	for i in range(array.size()):
		if array[i] and array[i].combo_priority > prio:
			prio = array[i].combo_priority
			index = i
	return index
