class_name BuildingBase
extends Node

export var _canselectbuilding : bool = true
export var _buildingname : String = "EmptyName" setget set_building_name,get_building_name
export var _buildingtype : String = "EmptyType" setget set_building_type,get_building_type


onready var GM:GameManager = get_tree().get_root().get_node("Main/GameManager")
onready var BuildingRootNode = owner


func _ready():
	pass


func _enter_tree():
	pass


func _exit_tree():
	pass


func can_selected() -> bool:
	return _canselectbuilding


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
