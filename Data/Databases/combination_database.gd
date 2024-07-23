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

func get_valid_combinations(ingredient)->Array[Combination]:
	var valid_combinations:Array[Combination]
	for combination in cache:
		var combo = cache[combination]
		var reqs = combo.requires
		
		if reqs.has(ingredient):
			valid_combinations.append(combo)
	
	return valid_combinations
