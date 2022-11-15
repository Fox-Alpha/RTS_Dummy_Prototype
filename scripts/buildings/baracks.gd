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
								"name": "BlueSoldier",
								"class": "Soldier",
								"color": Color.aliceblue,
								"buildtime": 1.5,
								"resorcescosts": "",
							},
							"2": {
								"name": "AzureSoldier",
								"class": "Tank",
								"color": Color.azure,
								"buildtime": 2.5,
								"resorcescosts": "",
							},
							"3": {
								"name": "CadetSoldier",
								"class": "Archer",
								"color": Color.cadetblue,
								"buildtime": 4.0,
								"resorcescosts": "",
							},
							"4": {
								"name": "ChartSoldier",
								"class": "Medic",
								"color": Color.chartreuse,
								"buildtime": 6.0,
								"resorcescosts": "",
							}
						}
	if _Get_ObjectTypeProperty("ObjectCanSpawnObjects"):
		if is_instance_valid(_UnitSpawnNode) and is_instance_valid(_UnitRallypointNode):
			UnitSpawnPos = _UnitSpawnNode.get_global_translation()
			UnitRallyPos = _UnitRallypointNode.get_global_translation()
#	ObjectTypeProperties[""] = ""
