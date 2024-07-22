class_name ItemBase
extends Resource

@export var name:String
@export var description:String
@export var UID:int
@export var icon:Texture2D
@export var value:int
@export var combo_priority:int
@export var type:ItemType

enum ItemType{
	None,
	Bottle,
	Herb,
	Water
}
