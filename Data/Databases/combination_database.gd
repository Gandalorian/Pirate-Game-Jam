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

func get_valid_combinations(ingredients):
	var valid_combinations:Array[Combination]
	for combination in cache:
		var combo = cache[combination]
		var reqs = combo.requires
		var andnot = combo.not_include
		
		var matches = 0
		if reqs.has(ingredients[1]):
			matches += 1
		if reqs.has(ingredients[2]):
			matches += 1
		if reqs.has(ingredients[3]):
			matches += 1
		if reqs.has(ingredients[4]):
			matches += 1
		
		if matches == 4:
			valid_combinations = [combo]
			return valid_combinations
		
		if matches >= 1:
			if ingredients[1] and andnot.has(ingredients[1].type): continue
			if ingredients[2] and andnot.has(ingredients[2].type): continue
			if ingredients[3] and andnot.has(ingredients[3].type): continue
			if ingredients[4] and andnot.has(ingredients[4].type): continue
			valid_combinations.append(combo)
	
	return valid_combinations
