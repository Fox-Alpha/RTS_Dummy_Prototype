extends Node
class_name UnitBase

var unit_is_selected:bool setget _set_unit_is_selected, _get_unit_is_selected 

var UnitObjectType:int setget _set_objecttype, _get_objecttype # OBJECT_TYPE_ENUM.TYPE_*
var UnitName : String setget _set_unit_name, _get_unit_name
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

var ObjectTypeProperties : Dictionary setget , _get_objecttypeproperties

#onready var GM = Globals.get_gamemanager_instance()

# onready var UnitRootNode = owner

onready var _UnitRootNode = get_parent()

onready var _UnitSpawnNode = .get_node_or_null("%UnitSpawnPosition3D")
onready var _UnitRallypointNode = .get_node_or_null("%UnitRallyPosition3D")


#-------------------------------------------------------------------------------
# optional built-in virtual methods
#-------------------------------------------------------------------------------
#func _init() -> void:
#	pass


func _ready() -> void:
# TODO: Abgleichen der Eigenschaften mit objecttype
	ObjectTypeProperties = {
		"ObjectType": Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING, 
		"ObjectInstanceID": -1,
		"ObjectName": "EmptyName",
		"ObjectTypeName": "EmptyTypeName",
		"ObjectCanSelect": false,
		"ObjectHasUI": false,
		"ObjectUI_ID": -1,
		"ObjectUiName": "EmptyUI",
		"ObjectCanSpawnObjects": false,
		"ObjectMaxBuildQueue": 10,
		"ObjectSpawnPos": Vector3(),
		"ObjectRallyPos": Vector3(),
		"ObjectsToSpawn": {}
	}
	UnitSpawnPos = Vector3.ZERO # _UnitSpawnNode.get_global_translation()
	UnitRallyPos = Vector3.ZERO # _UnitRallypointNode.get_global_translation()

#func _enter_tree():
#	print("UnitsNode::_enter_tree() -> ", name)
#	pass


#func _exit_tree():
#	print("UnitsNode::_exit_tree() -> ", name)
#	pass

#-------------------------------------------------------------------------------

func _set_unit_is_selected(value:bool):
	unit_is_selected = value


func  _get_unit_is_selected():
	return unit_is_selected

#-------------------------------------------------------------------------------

func _Set_ObjectTypeProperty(property, value) -> void:
	if ObjectTypeProperties.has(property):
		ObjectTypeProperties[property] = value


func _Get_ObjectTypeProperty(property:String):
	var prop
	if ObjectTypeProperties.has(property):
		prop = ObjectTypeProperties[property]
		# 
	return prop

#-------------------------------------------------------------------------------

# Abfrage und setzen des gesamten Property Dictionary
func _get_objecttypeproperties() -> Dictionary:
	return ObjectTypeProperties

#-------------------------------------------------------------------------------

func _set_objecttype(value:int):
	_Set_ObjectTypeProperty("ObjectType", value)


func _get_objecttype() -> int:
	return _Get_ObjectTypeProperty("ObjectType")

#-------------------------------------------------------------------------------
# CheckMe: Wo werden diese Methoden aufgerufen
# func can_selected() -> bool:
# 	return _canselectunit


# func can_moved() -> bool:
# 	return _canmoveunit

#-------------------------------------------------------------------------------

func _set_unit_name(value:String) -> void:
	if value != UnitName and not value.empty():
		_Set_ObjectTypeProperty("ObjectName", value)


func _get_unit_name() -> String:
	return _Get_ObjectTypeProperty("ObjectName")

#-------------------------------------------------------------------------------

func _set_unit_typename(value:String) -> void:
	if not value.empty():
		_Set_ObjectTypeProperty("ObjectTypeName", value)


func _get_unit_typename() -> String:
	return _Get_ObjectTypeProperty("ObjectTypeName")

#-------------------------------------------------------------------------------

func _set_unit_can_select(value):
	_Set_ObjectTypeProperty("ObjectCanSelect", value)

func _get_unit_can_select():
	return _Get_ObjectTypeProperty("ObjectCanSelect")

#-------------------------------------------------------------------------------

func _set_unit_ui_id(value:int) -> void:
	_Set_ObjectTypeProperty("ObjectUI_ID", value)


func _get_unit_ui_id() -> int:
	return _Get_ObjectTypeProperty("ObjectUI_ID")

#-------------------------------------------------------------------------------

func _set_unithasui(value):
	_Set_ObjectTypeProperty("ObjectHasUI", value)
	
func _get_unithasui():
	return _Get_ObjectTypeProperty("ObjectHasUI")

#-------------------------------------------------------------------------------

func _set_unit_uiname(value:String):
	if !value.empty():
		_Set_ObjectTypeProperty("ObjectUiName", value)


func _get_unit_uiname() -> String:
	return _Get_ObjectTypeProperty("ObjectUiName")

#-------------------------------------------------------------------------------

func  _set_canspawnunits(value):
	_Set_ObjectTypeProperty("ObjectCanSpawnObjects", value)


func _get_canspawnunits():
	return _Get_ObjectTypeProperty("ObjectCanSpawnObjects")

#-------------------------------------------------------------------------------

func _set_unit_spawnpoint(value):
	_Set_ObjectTypeProperty("ObjectSpawnPos", value)


func _get_unit_spawnpoint():
	return _Get_ObjectTypeProperty("ObjectSpawnPos")

#-------------------------------------------------------------------------------
# Set Rally Point
func _set_unit_rallypoint(newrallypoint):
	_Set_ObjectTypeProperty("ObjectRallyPos", newrallypoint)
	if is_instance_valid(_UnitRallypointNode):
		_UnitRallypointNode.set_global_translation(newrallypoint)


func _get_unit_rallypoint() -> Vector3:
	return _Get_ObjectTypeProperty("ObjectRallyPos")

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

# CheckMe: Prüfen wo diese Methoden aufgerufen werden
# func _set_unit_type(value:String) -> void:
# 	if value != UnitType and not value.empty():
# 		UnitType = value


# func _get_unit_type() -> String:
# 	return UnitType
