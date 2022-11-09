extends Node


var is_selected : bool = false
var is_moving : bool = false
var speed = 5.0

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


func _physics_process(delta):
	if is_moving:
		var MoveToThisPosition = _NavAgentNode.get_next_location()
		var velocity = (MoveToThisPosition - $Unit.transform.origin).normalized() * speed * delta
	
#		$Unit.move_and_collide(velocity)
		_NavAgentNode.set_velocity(velocity)


func _on_NavigationAgent_velocity_computed(_safe_velocity: Vector3) -> void:
		$Unit.move_and_collide(_safe_velocity)
#	pass # Replace with function body.


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	_NavAgentNode.set_target_location(newAgentTarget)
	var reachable = _NavAgentNode.is_target_reachable()
	if reachable:
		print_debug("is_target_reachable(): %s" % reachable)
#	_NavAgentNode.


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


func _on_NavigationAgent_path_changed():
	is_moving = true
#	pass # Replace with function body.


func _on_NavigationAgent_target_reached():
	is_moving = false
#	pass # Replace with function body.


func _on_NavigationAgent_navigation_finished():
	print_debug("_on_NavigationAgent_navigation_finished()")

#	pass # Replace with function body.
