extends Node

@onready var container = $Container
@onready var spawnpoints_container = $"Container/Spawn points"

var spawnpoints:Array[TextureButton] = []

signal on_shop_button_pressed

func _ready():
	for point_container in spawnpoints_container:
		for child in point_container.get_children():
			spawnpoints.append(child)

func spawn_gatherables():
	var amount_to_spawn = randi_range(3,spawnpoints.size())
	var amount_spawned = 0
	while(amount_spawned < amount_to_spawn):
		var point = spawnpoints[randi_range(0,spawnpoints.size())]
		if not point.item:
			point.set_gaterable(ItemDatabase.get_random_gaterable())
			amount_spawned += 1

func set_visible(visibility):
	container.visible = visibility

func _on_to_shop_button_pressed():
	on_shop_button_pressed.emit()

