extends Node
class_name BuildingBase

var building_is_selected:bool setget _set_building_is_selected, _get_building_is_selected 

var BuildingObjectType:int setget _set_objecttype, _get_objecttype # OBJECT_TYPE_ENUM.TYPE_*
var BuildingName : String setget _set_building_name, _get_building_name
var BuildingTypeName : String setget _set_building_typename, _get_building_typename
var BuildingCanSelect : bool setget _set_building_can_select, _get_building_can_select
var BuildingHasUI : bool setget _set_buildinghasui, _get_buildinghasui
var BuildingUiName : String setget _set_building_uiname, _get_building_uiname
var BuildingCanSpawnUnits : bool setget _set_canspawnunits, _get_canspawnunits
var UnitSpawnPos : Vector3 setget _set_building_spawnpoint, _get_building_spawnpoint
var UnitRallyPos : Vector3 setget _set_building_rallypoint, _get_building_rallypoint
var BuildingUI_ID : int setget _set_building_ui_id, _get_building_ui_id
# TODO: liste mit Variablen für den Public Zugriff vervollständigen
# ObjectParentName
# ObjectInstanceID
# ObjectType
# ObjectUI_ID
# ObjectsToSpawn
# "ObjectsToSpawn": {}


var ObjectTypeProperties : Dictionary setget , _Get_ObjectTypeProperties

var _ObjectBuildQueue : Array = []
var is_building = false
var is_build_pending = false


onready var _BuildingRootNode = get_parent()
onready var _ObjectTypeNode = get_node("%ObjectType")

onready var _UnitSpawnNode = .get_node_or_null("%UnitSpawnPosition3D")
onready var _UnitRallypointNode = .get_node_or_null("%UnitRallyPosition3D")


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():

# 	# Object selektieren
# 	if not Signalbus.is_connected("objectselected", self, "_on_select_object"):
# 		var _sig = Signalbus.connect("objectselected", self, "_on_select_object")
# #		assert(sig == OK, "ObjectManager::init_signals() -> connect objectselected failed")

# 	# Objecte Selektion aufheben
# 	if not Signalbus.is_connected("objectunselected", self, "_on_unselect_object"):
# 		var _sig = Signalbus.connect("objectunselected", self, "_on_unselect_object")
# #		assert(sig == OK, "ObjectManager::init_signals() -> connect objunectselected failed")
	
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
	UnitSpawnPos = _UnitSpawnNode.get_global_translation()
	UnitRallyPos = _UnitRallypointNode.get_global_translation()


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass


#func _process(_delta):
#	pass

# ===========================

# ===========================

func _set_building_is_selected(value:bool):
	building_is_selected = value


func  _get_building_is_selected():
	return building_is_selected

# ===========================


# ===========================

func _Set_ObjectTypeProperty(property, value) -> void:
	if ObjectTypeProperties.has(property):
		ObjectTypeProperties[property] = value


func _Get_ObjectTypeProperty(property:String):
	var prop
	if ObjectTypeProperties.has(property):
		prop = ObjectTypeProperties[property]
		# 
	return prop
	
# ===========================

# Abfrage und setzen des gesamten Property Dictionary
func _Get_ObjectTypeProperties() -> Dictionary:
	return ObjectTypeProperties


func _set_objecttype(value:int):
	_Set_ObjectTypeProperty("ObjectType", value)

# ===========================

func _get_objecttype() -> int:
	return _Get_ObjectTypeProperty("ObjectType")

# ===========================

func _set_building_name(value:String) -> void:
	if value != BuildingName and not value.empty():
		_Set_ObjectTypeProperty("ObjectName", value)


func _get_building_name() -> String:
	return _Get_ObjectTypeProperty("ObjectName")

# ===========================

func _set_building_typename(value:String) -> void:
	if not value.empty():
		_Set_ObjectTypeProperty("ObjectTypeName", value)


func _get_building_typename() -> String:
	return _Get_ObjectTypeProperty("ObjectTypeName")

# ===========================

func _set_building_can_select(value):
	_Set_ObjectTypeProperty("ObjectCanSelect", value)


func _get_building_can_select():
	return _Get_ObjectTypeProperty("ObjectCanSelect")

# ===========================

func _set_building_ui_id(value:int) -> void:
	_Set_ObjectTypeProperty("ObjectUI_ID", value)


func _get_building_ui_id() -> int:
	return _Get_ObjectTypeProperty("ObjectUI_ID")

# ===========================

func _set_buildinghasui(value):
	_Set_ObjectTypeProperty("ObjectHasUI", value)
	
func _get_buildinghasui():
	return _Get_ObjectTypeProperty("ObjectHasUI")

# ===========================

func _set_building_uiname(value:String):
	if !value.empty():
		_Set_ObjectTypeProperty("ObjectUiName", value)


func _get_building_uiname() -> String:
	return _Get_ObjectTypeProperty("ObjectUiName")

# ===========================

func  _set_canspawnunits(value):
	_Set_ObjectTypeProperty("ObjectCanSpawnObjects", value)


func _get_canspawnunits():
	return _Get_ObjectTypeProperty("ObjectCanSpawnObjects")

# ===========================

func _set_building_spawnpoint(value):
	_Set_ObjectTypeProperty("ObjectSpawnPos", value)


func _get_building_spawnpoint():
	return _Get_ObjectTypeProperty("ObjectSpawnPos")

# ===========================
# Set Rally Point
func _set_building_rallypoint(newrallypoint):
	_Set_ObjectTypeProperty("ObjectRallyPos", newrallypoint)
	if is_instance_valid(_UnitRallypointNode):
		_UnitRallypointNode.set_global_translation(newrallypoint)


func _get_building_rallypoint() -> Vector3:
	return _Get_ObjectTypeProperty("ObjectRallyPos")

# ===========================

