extends Spatial


export var _canselectbuilding : bool = true
export var is_selected:bool = false 

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var BuildingMesh = $BaracksBody/MeshBuilding
onready var shader:ShaderMaterial = BuildingMesh.mesh.material.next_pass


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	is_selected = selected
	if is_selected:
		shader.set_shader_param("strenght", 1.0)
	else:
		shader.set_shader_param("strenght", 0.0)


func GetBuildingHasUI() -> bool:
	return _ObjectTypeNode._buildinghasui


func GetBuildingUIName() -> String:
	return _ObjectTypeNode.get_building_uiname()

func SetBuildingRallypoint(newpos : Vector3):
	_ObjectTypeNode.set_building_rallypoint(newpos)
#	pass

func can_objectselected() -> bool:
	return _canselectbuilding


func get_objecttype_node() -> Node:
	return _ObjectTypeNode


func get_objecttype():
	return _ObjectTypeNode._ObjectType


# Called when the node enters the scene tree for the first time.
func _ready():
#	if get_objecttype_node()._buildingcanspawnunits:
	shader = BuildingMesh.mesh.material.next_pass
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
