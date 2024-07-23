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
		ingreds.append(child.item)
	var possibleResults:Array[Combination] = []
	# For each ingredient
	while(ingreds.size() >= 1):
		# Find which ingredient has highest prio, and save it's index
		var index = find_prio(ingreds)
		# Get all possible combinations with highest prio ingredient
		possibleResults.append_array(CombinationDatabase.get_valid_combinations(ingreds[index]))
		# If only one result, do that combination
		if possibleResults.size() == 1: 
			do_combination(possibleResults[0])
			return
		# Otherwise, remove that ingredient from list of ingredients to check, and go again
		ingreds.remove_at(index)
	# If no possible combinations, return
	if possibleResults.size() == 0: return
	# Otherwise, if list of possible combinations not narrowed down to one at this point, do random combination
	do_combination(possibleResults[randi_range(0,possibleResults.size() - 1)])

func on_dropped_item(item:ItemBase):
	on_dropped_ingredient.emit(item)

func on_undropped_item(item:ItemBase):
	add_to_inventory.emit(item,1)

func _on_recipe_book_button_pressed():
	if recipebook.visible: return
	recipebook.visible = true
	animplayer.play("open_recipe_book")

func do_combination(combo):
	add_to_inventory.emit(combo.result,combo.amount)
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
