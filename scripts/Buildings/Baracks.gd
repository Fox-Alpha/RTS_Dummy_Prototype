class_name Barracks
extends BuildingBase


@onready var UnitSpawn = get_node("%UnitSpawnPosition3D")


func _ready():
	_buildingtype = "BuildingArmyBarrack"
	_buildingname = "Army Barrack"
	pass
