class_name BuildingBase
extends Node

# TODO: Rechtsklick soll Rallypoint setzen

export var _buildingname : String = "EmptyName" setget set_building_name,get_building_name
export var _buildingtype : String = "EmptyType" setget set_building_type,get_building_type
export var _ObjectType:int = 1 setget _set_objecttype, get_objecttype


onready var GM = .get_tree().get_root().get_node("Main/GameManager")
#var GMInstance setget set_gamemanagerinstance, _get_gamemanagerinstance
onready var BuildingRootNode = get_parent()


func _ready():
	pass


func _enter_tree():
	pass


func _exit_tree():
	pass


func _set_objecttype(value):
	_ObjectType = value
	pass


func get_objecttype():
	return _ObjectType
	pass


func set_building_name(value:String) -> void:
	if value != _buildingname and not value.empty():
		_buildingname = value


func get_building_name() -> String:
	return _buildingname


func set_building_type(value:String) -> void:
	if value != _buildingtype and not value.empty():
		_buildingtype = value


func get_building_type() -> String:
	return _buildingtype
