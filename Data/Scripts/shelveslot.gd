extends TextureRect
class_name ShelveSlot

@onready var amount = $Label

var item
var count

func has_point(at_position):
	if at_position.x < global_position.x or at_position.x > global_position.x + size.x: return false
	if at_position.y < global_position.y or at_position.y > global_position.y + size.y: return false
	return true

func _get_drag_data(at_position):
	var data = [texture,item,count]
	var prev = duplicate()
	var c = Control.new()
	c.add_child(prev)
	prev.position = -0.5 * size
	set_drag_preview(c)
	return data

func set_item_and_count(i,c):
	item = i
	count = c
	amount.text = "...".format([c], "...")
