extends Node

@onready var container = $Container

signal on_alch_button_pressed
signal on_garden_button_pressed

func _ready():
	pass # Replace with function body.

func set_visible(visibility):
	container.visible = visibility

func _on_to_garden_button_pressed():
	on_garden_button_pressed.emit()

func _on_to_alch_button_pressed():
	on_alch_button_pressed.emit()
