extends BuildingBase
class_name Barracks


#var ObjectTypeProperties:Dictionary = {
#	"ObjectType": Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING, 
#	"ObjectName": "EmptyName",
#	"ObjectTypeName": "EmptyTypeName",
#	"ObjectCanSelect": false,
#	"ObjectHasUI": false,
#	"ObjectUiName": "EmptyUI",
#	"ObjectCanSpawnObjects": false,
#	"ObjectSpawnPos": Vector3(),
#	"ObjectRallyPos": Vector3(),
#	"ObjectToSpawn": {}
#}


func _ready():
	_initobjectproperties()
#	pass


func _initobjectproperties():
	ObjectTypeProperties["ObjectParentName"] = _BuildingRootNode.name
	ObjectTypeProperties["ObjectInstanceID"] = get_parent().get_instance_id()
	ObjectTypeProperties["ObjectType"] = Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING
	ObjectTypeProperties["ObjectName"] = "Army Barrack"
	ObjectTypeProperties["ObjectTypeName"] = "BuildingArmyBarrack"
	ObjectTypeProperties["ObjectCanSelect"] = true
	ObjectTypeProperties["ObjectHasUI"] = true
	ObjectTypeProperties["ObjectUiName"] = "UI_Barracks"
	ObjectTypeProperties["ObjectCanSpawnObjects"] = true
	ObjectTypeProperties["ObjectSpawnPos"] = UnitSpawnPos
	ObjectTypeProperties["ObjectRallyPos"] = UnitRallyPos
	ObjectTypeProperties["ObjectsToSpawn"] = {
							"1": {
								"name": "RED",
								"class": "Soldier",
								"color": Color.red,
								"buildtime": 6.0,
								"resorcescosts": "",
							},
							"2": {
								"name": "BLUE",
								"class": "Tank",
								"color": Color.blue,
								"buildtime": 6.0,
								"resorcescosts": "",
							},
							"3": {
								"name": "GREEN",
								"class": "Archer",
								"color": Color.green,
								"buildtime": 6.0,
								"resorcescosts": "",
							},
							"4": {
								"name": "WHITE",
								"class": "Medic",
								"color": Color.white,
								"buildtime": 6.0,
								"resorcescosts": "",
							}
						}
	if _Get_ObjectTypeProperty("ObjectCanSpawnObjects"):
		if is_instance_valid(_UnitSpawnNode) and is_instance_valid(_UnitRallypointNode):
			UnitSpawnPos = _UnitSpawnNode.get_global_translation()
			UnitRallyPos = _UnitRallypointNode.get_global_translation()
#	ObjectTypeProperties[""] = ""
