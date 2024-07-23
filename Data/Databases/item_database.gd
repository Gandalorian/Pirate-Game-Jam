extends Node

var cache : Dictionary = {}

@export_dir var item_folder

func _ready():
	var folder = DirAccess.open(item_folder)
	folder.list_dir_begin()
	
	var file_name = folder.get_next()
	
	while file_name != "":
		cache[file_name] = load(item_folder + "/" + file_name)
		file_name = folder.get_next()

func get_item(ID):
	return cache[ID + ".tres"]

func get_random_gaterable():
	var gatherables = []
	for key in cache:
		var item = cache[key]
		if item.type == ItemBase.ItemType.Gatherable:
			gatherables.append(item)
	return gatherables[randi() % gatherables.size()]
