extends Node

@onready var titlescreen = preload("res://Scenes/title_screen.tscn").instantiate()
@onready var shopscreen = preload("res://Scenes/shop_screen.tscn").instantiate()
@onready var gardenscreen = preload("res://Scenes/garden_screen.tscn").instantiate()
@onready var alchemyscreen = preload("res://Scenes/alchemy_lab_screen.tscn").instantiate()

@onready var animplayer = $"Scene Transition Animation Player"
@onready var inventory = $Inventory

@onready var inventory_popup = preload("res://Utility/UI/Scenes/inventory_popup.tscn")
@onready var popup_container = $"Popup Container"

var title: Node
var shop: Node
var garden: Node
var alchemy: Node

var root

func _ready():
	root = get_tree().root.get_child(-1)
	setup_title()
	setup_shop()
	setup_garden()
	setup_alchemy()
	shop.set_visible(false)
	garden.set_visible(false)
	alchemy.set_visible(false)
	
	# Test inventory
	inventory.add(ItemDatabase.get_item("bottle_of_water"),10)
	inventory.add(ItemDatabase.get_item("herb1"),1)
	inventory.add(ItemDatabase.get_item("herb2"),1)
	inventory.add(ItemDatabase.get_item("herb3"),1)
	inventory.add(ItemDatabase.get_item("herb4"),1)
	inventory.add(ItemDatabase.get_item("herb5"),1)
	inventory.add(ItemDatabase.get_item("herb6"),1)
	
	inventory.update_inventory.connect(update_inventory)
	inventory.added_to_inventory.connect(play_inventory_popup)

# Setup functions
func setup_title():
	root.add_child(titlescreen)
	title = root.get_child(-1)
	title.on_start_button_pressed.connect(start_game)

func setup_shop():
	root.add_child(shopscreen)
	shop = root.get_child(-1)
	shop.on_alch_button_pressed.connect(scene_to_scene)
	shop.on_garden_button_pressed.connect(scene_to_scene)

func setup_garden():
	root.add_child(gardenscreen)
	garden = root.get_child(-1)
	garden.on_shop_button_pressed.connect(scene_to_scene)
	garden.on_gatherable_pressed.connect(inventory.add)

func setup_alchemy():
	root.add_child(alchemyscreen)
	alchemy = root.get_child(-1)
	alchemy.on_shop_button_pressed.connect(scene_to_scene)
	alchemy.on_update_inventory.connect(update_inventory)
	alchemy.on_dropped_ingredient.connect(inventory.remove)
	alchemy.add_to_inventory.connect(inventory.add)
	
func start_game():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	title.set_visible(false)
	shop.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished

# Changing scene functions
func scene_to_scene(scene1, scene2):
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	match(scene1):
		"alchemy": alchemy.set_visible(false)
		"garden": garden.set_visible(false)
		"shop": shop.set_visible(false)
	match(scene2):
		"alchemy": alchemy.set_visible(true)
		"garden": 
			garden.set_visible(true)
			garden.spawn_gatherables()
		"shop": shop.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished

# Utility functions
func update_inventory():
	alchemy.update_inventory(inventory.container)

func play_inventory_popup(item,count):
	var popup = inventory_popup.instantiate()
	popup_container.add_child(popup)
	popup.setup(item,count)
	popup.play()

