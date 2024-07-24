extends Control

@onready var icon = $"Panel/Container/Item icon"
@onready var item_name = $"Panel/Container/Text/Item name"
@onready var animplayer = $PopupPlayer

var setup_queue = []

func _ready():
	animplayer.animation_finished.connect(handle_autoplay)

func setup(item,count):
	icon.texture = item.icon
	item_name.text = "x... ...".format([count,item.name], "...")

func add_to_setup_queue(item,count):
	setup_queue.append({"item":item,"count":count})

func pop_setup_queue():
	if setup_queue.size() < 1: return
	
	var first = setup_queue.pop_front()
	setup(first["item"],first["count"])
	animplayer.play("Popup/added_to_inventory_popup")

func handle_autoplay(anim_name):
	print(anim_name)
	match(anim_name):
		"Popup/added_to_inventory_popup": pop_setup_queue()

func play_anim(anim:String):
	animplayer.play(anim)
