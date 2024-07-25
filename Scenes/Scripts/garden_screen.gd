extends Node

@onready var container = $Container
@onready var spawnpoints_container = $"Container/Spawn points"

var spawnpoints:Array[TextureButton] = []

signal on_shop_button_pressed
signal on_gatherable_pressed(item:ItemBase)

func _ready():
	for point_container in spawnpoints_container.get_children():
		for child in point_container.get_children():
			child.visible = false
			child.on_pressed_gatherable.connect(pressed_gatherable)
			spawnpoints.append(child)

func spawn_gatherables():
	# Randomize amount to spawn
	var amount_to_spawn = randi_range(3,spawnpoints.size())
	var amount_spawned = 0
	# Check already spawned
	for point in spawnpoints:
		if point.item: amount_spawned += 1
	# Spawn new
	while(amount_spawned < amount_to_spawn):
		var point = spawnpoints[randi_range(0,spawnpoints.size() - 1)]
		if not point.item:
			point.set_gatherable(ItemDatabase.get_random_gatherable())
			point.visible = true
			amount_spawned += 1

func set_visible(visibility):
	container.visible = visibility

func _on_to_shop_button_pressed():
	on_shop_button_pressed.emit("garden","shop")

func pressed_gatherable(item:ItemBase):
	on_gatherable_pressed.emit(item)
