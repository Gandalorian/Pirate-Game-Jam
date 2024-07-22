extends Node

signal on_start_button_pressed
signal on_settings_button_pressed

func _on_start_button_pressed():
	#print("start")
	on_start_button_pressed.emit()

func _on_settings_button_pressed():
	#print("settings")
	on_settings_button_pressed.emit()
	
func _on_exit_button_pressed():
	get_tree().quit()

func set_visible(visibility):
	for child in get_children():
		child.visible = visibility
