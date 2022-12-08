class_name UnitBase
extends Node

var unit_is_selected:bool setget _set_unit_is_selected, _get_unit_is_selected 

var UnitObjectType:int setget _set_objecttype, _get_objecttype # OBJECT_TYPE_ENUM.TYPE_*
var UnitName : String setget set_unit_name, get_unit_name
var UnitTypeName : String setget _set_unit_typename, _get_unit_typename
var UnitCanSelect : bool setget _set_unit_can_select, _get_unit_can_select
var UnitHasUI : bool setget _set_unithasui, _get_unithasui
var UnitUiName : String setget _set_unit_uiname, _get_unit_uiname
var UnitCanSpawnUnits : bool setget _set_canspawnunits, _get_canspawnunits
var UnitSpawnPos : Vector3 setget _set_unit_spawnpoint, _get_unit_spawnpoint
var UnitRallyPos : Vector3 setget _set_unit_rallypoint, _get_unit_rallypoint
var UnitUI_ID : int setget _set_unit_ui_id, _get_unit_ui_id
# TODO: liste mit Variablen für den Public Zugriff vervollständigen
# ObjectParentName
# ObjectInstanceID
# ObjectType
# ObjectUI_ID
# ObjectsToSpawn
# "ObjectsToSpawn": {}

#export var UnitName : String = "EmptyUnitName" setget set_unit_name, get_unit_name
#export var UnitType : String = "EmptyUnitType" setget set_unit_type, get_unit_type

export var _canselectunit : bool = true
export var _canmoveunit : bool = true

var _ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT

#onready var GM = Globals.get_gamemanager_instance()

# onready var UnitRootNode = owner

onready var _UnitRootNode = get_parent()


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
