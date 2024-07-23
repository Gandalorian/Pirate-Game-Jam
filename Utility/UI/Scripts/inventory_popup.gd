extends Panel

@onready var icon = $"Container/Item icon"
@onready var item_name = $"Container/Text/Item name"

func setup(item,count):
	icon.texture = item.icon
	item_name.text = "x... ...".format([count,item.name], "...")
