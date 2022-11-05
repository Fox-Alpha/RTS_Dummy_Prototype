class_name UnitBase
extends Node


@export var UnitName : String = "EmptyUnitName" :
	get:
		return UnitName # TODOConverter40 Copy here content of get_unit_name
	set(mod_value):
		mod_value  # TODOConverter40 Copy here content of set_unit_name
@export var UnitType : String = "EmptyUnitType" :
	get:
		return UnitType # TODOConverter40 Copy here content of get_unit_type
	set(mod_value):
		mod_value  # TODOConverter40 Copy here content of set_unit_type

@export var _canselectunit : bool = true

@onready var GM:GameManager = get_tree().get_root().get_node("Main/GameManager")
@onready var UnitRootNode = owner


func _ready():
	pass


func _enter_tree():
	pass


func _exit_tree():
	pass


func can_selected() -> bool:
	return _canselectunit


func set_unit_name(value:String) -> void:
	if value != UnitName and not value.is_empty():
		UnitName = value


func get_unit_name() -> String:
	return UnitName


func set_unit_type(value:String) -> void:
	if value != UnitType and not value.is_empty():
		UnitType = value


func get_unit_type() -> String:
	return UnitType
