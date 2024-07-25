extends TextureButton

signal on_drop(data)

func _can_drop_data(_at_position, data):
	return true

func _drop_data(_at_position, data):
	on_drop.emit(data)
