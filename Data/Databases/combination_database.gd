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

func get_combination(ingredients)->Dictionary:
	var to_return = {}
	
	var match_4:Array[Combination] = []
	var match_3:Array[Combination] = []
	var match_2:Array[Combination] = []
	var match_1:Array[Combination] = []
	
	for combination in cache:
		var combo = cache[combination]
		var reqs = combo.requires
		
		var matches = 0
		for i in ingredients:
			if reqs.has(i):
				matches += 1
		match(matches):
			4: if reqs.size() == 4: match_4.append(combo)
			3: if reqs.size() == 3: match_3.append(combo)
			2: if reqs.size() == 2: match_2.append(combo)
			1: if reqs.size() == 1: match_1.append(combo)
	
	if match_4.size() > 0:
		to_return["combo"] = match_4[0]
		to_return["extra"] = 0
		return to_return
	
	if match_3.size() > 0:
		to_return["extra"] = ingredients.size() - 3
		if match_3.size() < 2:
			to_return["combo"] = match_3[0]
		else:
			var i = randi_range(0,match_3.size()-1)
			to_return["combo"] = match_3[i]
		return to_return
	
	if match_2.size() > 0:
		to_return["extra"] = ingredients.size() - 2
		if match_2.size() < 2:
			to_return["combo"] = match_2[0]
		else:
			var i = randi_range(0,match_2.size()-1)
			to_return["combo"] = match_2[i]
		return to_return
	
	if match_1.size() > 0:
		to_return["extra"] = ingredients.size() - 1
		if match_1.size() < 2:
			to_return["combo"] = match_1[0]
		else:
			var i = randi_range(0,match_1.size()-1)
			to_return["combo"] = match_1[i]
		return to_return
	
	return to_return
