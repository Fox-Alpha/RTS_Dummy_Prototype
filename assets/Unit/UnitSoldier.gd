extends Node


var is_selected : bool = false

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var _NavAgentNode = get_node_or_null("%NavigationAgent")
onready var UnitMesh = $Unit/MeshBody
onready var shader:ShaderMaterial = UnitMesh.mesh.material.next_pass


func _ready():
	_ObjectTypeNode._ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT
	_ObjectTypeNode.UnitType = "UnitSoldierBase"
	_ObjectTypeNode.UnitName = "Basic Soldier"
	if _NavAgentNode == null:
		_ObjectTypeNode._canmoveunit = false
	pass


func _on_NavigationAgent_velocity_computed(_safe_velocity: Vector3) -> void:
	pass # Replace with function body.


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	_NavAgentNode.set_target_location(newAgentTarget)


func can_objectselected() -> bool:
	return _ObjectTypeNode.can_selected()


func get_objecttype():
	return _ObjectTypeNode._ObjectType


func select_object(selected:bool) -> void:
	print_debug("BuildingRoot::select_object() -> Building selected: %s" % selected)
	is_selected = selected
	if is_selected:
		shader.set_shader_param("strenght", 1.0)
	else:
		shader.set_shader_param("strenght", 0.0)
