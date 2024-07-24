extends Node2D

@export var shelveslots:Array[ShelveSlot]

func update_inventory(inventory):
	for i in range(shelveslots.size()):
		if i > inventory.size() - 1: shelveslots[i].visible = false
		else: 
			shelveslots[i].visible = true
			shelveslots[i].texture = inventory[i].item.icon
			shelveslots[i].set_item_and_count(inventory[i].item, inventory[i].count)
		
