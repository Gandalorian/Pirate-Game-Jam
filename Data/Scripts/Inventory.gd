class_name Inventory
extends Node

var container:Array[InventorySlot]
var money = 0

signal update_inventory
signal added_to_inventory(item,count)

func _ready():
	container = []

func add(item, count = 1):
	added_to_inventory.emit(item,count)
	print("added")
	for slot in container:
		if item == slot.item:
			slot.count += count
			update_inventory.emit()
			return
	container.append(InventorySlot.new(item,count))
	update_inventory.emit()

func remove(item, count = 1):
	print("remove ... from inventory".format([item.name], "..."))
	for slot in container:
		if item == slot.item:
			slot.count -= count
			if slot.count <= 0:
				container.erase(slot)
			print("... ... left in inventory".format([slot.count, item.name], "..."))
			update_inventory.emit()
			return true
	#print("No ... found in inventory".format([item.name], "..."))
	return false

func get_count(item):
	pass

