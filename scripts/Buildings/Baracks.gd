class_name Barracks
extends BuildingBase


onready var UnitSpawnPos = .get_node("%UnitSpawnPosition3D")
onready var UnitRallyPos = .get_node("%UnitRallyPosition3D")


func _ready():
	_buildingtype = "BuildingArmyBarrack"
	_buildingname = "Army Barrack"
	pass
