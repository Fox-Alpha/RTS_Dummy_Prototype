class_name UnitBase
extends Node


export var UnitName : String = "EmptyUnitName" setget set_unit_name, get_unit_name
export var UnitType : String = "EmptyUnitType" setget set_unit_type, get_unit_type

export var _canselectunit : bool = true
export var _canmoveunit : bool = true

var _ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNDEFINED

#onready var GM = Globals.get_gamemanager_instance()

onready var UnitRootNode = owner


#-------------------------------------------------------------------------------
# optional built-in virtual methods
#-------------------------------------------------------------------------------
#func _init() -> void:
#	pass


# func _ready() -> void:
# 	pass

#func _enter_tree():
#	print("UnitsNode::_enter_tree() -> ", name)
#	pass


#func _exit_tree():
#	print("UnitsNode::_exit_tree() -> ", name)
#	pass

#-------------------------------------------------------------------------------

func can_selected() -> bool:
	return _canselectunit


func can_moved() -> bool:
	return _canmoveunit


func _set_objecttype(value):
	_ObjectType = value


func get_objecttype():
	return _ObjectType


func set_unit_name(value:String) -> void:
	if value != UnitName and not value.empty():
		UnitName = value


func get_unit_name() -> String:
	return UnitName


func set_unit_type(value:String) -> void:
	if value != UnitType and not value.empty():
		UnitType = value


func get_unit_type() -> String:
	return UnitType
