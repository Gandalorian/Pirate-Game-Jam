extends Node

@onready var titlescreen = preload("res://Scenes/title_screen.tscn").instantiate()
@onready var shopscreen = preload("res://Scenes/shop_screen.tscn").instantiate()
@onready var gardenscreen = preload("res://Scenes/garden_screen.tscn").instantiate()
@onready var alchemyscreen = preload("res://Scenes/alchemy_lab_screen.tscn").instantiate()

@onready var animplayer = $AnimationPlayer
@onready var inventory = $Inventory

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
	inventory.add(ItemDatabase.get_item("test_item"),1)
	inventory.add(ItemDatabase.get_item("herb1"),1)
	inventory.add(ItemDatabase.get_item("herb2"),1)
	inventory.add(ItemDatabase.get_item("herb3"),1)
	inventory.add(ItemDatabase.get_item("herb4"),1)
	inventory.add(ItemDatabase.get_item("herb5"),1)
	inventory.add(ItemDatabase.get_item("herb6"),1)
	
	inventory.update_inventory.connect(update_inventory)

# Setup functions
func setup_title():
	root.add_child(titlescreen)
	title = root.get_child(-1)
	title.on_start_button_pressed.connect(start_game)

func setup_shop():
	root.add_child(shopscreen)
	shop = root.get_child(-1)
	shop.on_alch_button_pressed.connect(shop_to_alch)
	shop.on_garden_button_pressed.connect(shop_to_garden)

func setup_garden():
	root.add_child(gardenscreen)
	garden = root.get_child(-1)
	garden.on_shop_button_pressed.connect(garden_to_shop)

func setup_alchemy():
	root.add_child(alchemyscreen)
	alchemy = root.get_child(-1)
	alchemy.on_shop_button_pressed.connect(alch_to_shop)
	alchemy.on_update_inventory.connect(update_inventory)
	alchemy.on_dropped_ingredient.connect(inventory.remove)
	alchemy.add_to_inventory.connect(inventory.add)
	
func start_game():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	title.set_visible(false)
	alchemy.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished
	

# Changing scene functions
func alch_to_garden():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	alchemy.set_visible(false)
	garden.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished
	
func alch_to_shop():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	alchemy.set_visible(false)
	shop.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished
	
func shop_to_garden():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	shop.set_visible(false)
	garden.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished

func shop_to_alch():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	shop.set_visible(false)
	alchemy.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished

func garden_to_shop():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	garden.set_visible(false)
	shop.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished
	
func garden_to_alch():
	animplayer.play("fade_to_black")
	await animplayer.animation_finished
	garden.set_visible(false)
	alchemy.set_visible(true)
	animplayer.play("fade_from_black")
	await animplayer.animation_finished

# Utility functions
func update_inventory():
	alchemy.update_inventory(inventory.container)
