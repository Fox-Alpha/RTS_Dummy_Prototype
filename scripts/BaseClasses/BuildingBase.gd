class_name BuildingBase
extends Node

@export var _canselectbuilding : bool = true
@export var _buildingname : String = "EmptyName" :
	get:
		return _buildingname # TODOConverter40 Copy here content of get_building_name
	set(mod_value):
		mod_value  # TODOConverter40 Copy here content of set_building_name
@export var _buildingtype : String = "EmptyType" :
	get:
		return _buildingtype # TODOConverter40 Copy here content of get_building_type
	set(mod_value):
		mod_value  # TODOConverter40 Copy here content of set_building_type


@onready var GM:GameManager = get_tree().get_root().get_node("Main/GameManager")
@onready var BuildingRootNode = owner


func _ready():
	pass


func _enter_tree():
	pass


func _exit_tree():
	pass


func can_selected() -> bool:
	return _canselectbuilding


func set_building_name(value:String) -> void:
	if value != _buildingname and not value.is_empty():
		_buildingname = value


func get_building_name() -> String:
	return _buildingname


func set_building_type(value:String) -> void:
	if value != _buildingtype and not value.is_empty():
		_buildingtype = value


func get_building_type() -> String:
	return _buildingtype
