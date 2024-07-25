extends Control

@onready var icon = $"Panel/Container/Item icon"
@onready var item_name = $"Panel/Container/Text/Item name"
@onready var player = $PopupPlayer

func play():
	player.play("Popup/added_to_inventory_popup")

func setup(item,count):
	icon.texture = item.icon
	item_name.text = "x. .".format([count,item.name],".")

func _on_popup_player_animation_finished(anim_name):
	queue_free()
