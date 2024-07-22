extends Node

@onready var container = $Container

signal on_shop_button_pressed

func _ready():
	pass # Replace with function body.

func set_visible(visibility):
	container.visible = visibility

func _on_to_shop_button_pressed():
	on_shop_button_pressed.emit()

