extends Spatial


onready var _ObjectTypeNode = get_node("%ObjectType")
onready var BuildingMesh = $BaracksBody/MeshBuilding
onready var shader:ShaderMaterial = BuildingMesh.mesh.material.next_pass

onready var unit = preload("res://assets/unit/unit.tscn")

var ui_manager
var GM : Node


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	shader = BuildingMesh.mesh.material.next_pass
	
	GM = Globals.get_gamemanager_instance()
	if not Signalbus.is_connected("newobject_instantiated", self, "_on_instantiate_new_object"):
		var _sig = Signalbus.connect("newobject_instantiated", self, "_on_instantiate_new_object")


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# ===========================
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
# ===========================
func _on_instantiate_new_object(newType:int):
#	print_debug("OM: Neuen Typ erstellen: ", newType)
	if not _ObjectTypeNode.building_is_selected:
		return
			
	var props = _ObjectTypeNode.ObjectTypeProperties
	if props.ObjectsToSpawn.has(String(newType)):
		print_debug("Buildingroot: Neuen Typ erstellen: ", newType)



func _manage_ui(showui:bool):
	ui_manager = GM.get_manager_instance("UIManager")

	if is_instance_valid(ui_manager):
		if GetObjectHasUI():
			ui_manager.show_ui_instance(GetObjectUIName(), showui, GetObjectProperties())


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	_ObjectTypeNode.building_is_selected = selected
	if _ObjectTypeNode.building_is_selected:
		shader.set_shader_param("strenght", 1.0)
		# DONE: UI Anzeigen lassen
		_manage_ui(true)
	else:
		shader.set_shader_param("strenght", 0.0)
		# DONE: UI Ausblenden lassen
		_manage_ui(false)


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
