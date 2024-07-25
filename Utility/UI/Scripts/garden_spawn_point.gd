extends TextureButton

signal on_pressed_gatherable(item:ItemBase)

var item

func set_gatherable(new:ItemBase):
	item = new
	texture_normal = new.icon

func reset():
	item = null
	texture_normal = null
	visible = false

func _on_pressed():
	on_pressed_gatherable.emit(item.gather_result)
	reset()
