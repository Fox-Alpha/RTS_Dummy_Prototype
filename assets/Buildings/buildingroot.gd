extends Spatial


# var _canselectbuilding : bool = true
# var is_selected:bool = false 

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var BuildingMesh = $BaracksBody/MeshBuilding
onready var shader:ShaderMaterial = BuildingMesh.mesh.material.next_pass


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	shader = BuildingMesh.mesh.material.next_pass


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# ===========================
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# ===========================


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	_ObjectTypeNode.building_is_selected = selected
	if _ObjectTypeNode.building_is_selected:
		shader.set_shader_param("strenght", 1.0)
		# TRYME: UI Anzeigen lassen
	else:
		shader.set_shader_param("strenght", 0.0)
		# TRYME: UI Ausblenden lassen


func GetObjectProperties() -> Dictionary:
	return _ObjectTypeNode.ObjectTypeProperties

func get_objecttype() -> int:
	return _ObjectTypeNode.BuildingObjectType

func GetObjectName() -> String:
	return _ObjectTypeNode.BuildingName


func GetObjectTypeName() -> String:
	return _ObjectTypeNode.BuildingTypeName


# func GetBuildingCanSelect() -> bool:
func can_objectselected() -> bool:
	var b = _ObjectTypeNode.BuildingCanSelect
	return b


func GetObjectHasUI() -> bool:
	return _ObjectTypeNode.BuildingHasUI


func GetObjectUIName() -> String:
	return _ObjectTypeNode.BuildingUiName


func GetObjectCanSpawnUnits() -> bool:
	return _ObjectTypeNode.BuildingCanSpawnUnits


func GetBuildingSpawnPos() -> Vector3:
	return _ObjectTypeNode.UnitSpawnPos


func GetBuildingRallyPos() -> Vector3:
	return _ObjectTypeNode.UnitRallyPos


func SetBuildingRallyPoint(pos:Vector3):
	_ObjectTypeNode.UnitRallyPos = pos

#####
