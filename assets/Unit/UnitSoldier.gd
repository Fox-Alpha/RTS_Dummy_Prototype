extends KinematicBody


var is_selected : bool = false
var is_moving : bool = false
var speed = 5.0

export (float, 0, 100, 0.5) var movement_speed = 5.0

onready var _ObjectTypeNode = get_node("%ObjectType")
onready var _NavAgentNode = get_node_or_null("%NavigationAgent")
onready var _NavMapNode = get_tree().get_root().get_node("./Main/World/WorldNavigation")
onready var _NavPointNodeParent = get_tree().get_root().get_node("./Main/World/NavPoints")
onready var UnitMesh = $MeshBody
onready var shader:ShaderMaterial = UnitMesh.mesh.material.next_pass
onready var wnm = .get_tree().get_root().get_world().get_navigation_map()
onready var NavPoint = preload("res://assets/helper/NavPoint.tscn")


func _ready():
	_ObjectTypeNode._ObjectType = Globals.OBJECT_TYPE_ENUM.TYPE_UNIT
	_ObjectTypeNode.UnitType = "UnitSoldierBase"
	_ObjectTypeNode.UnitName = "Basic Soldier"
	if _NavAgentNode == null:
		_ObjectTypeNode._canmoveunit = false

	var nm:RID = _NavAgentNode.get_navigation_map()
	print_debug("NavigationMap RID Id: ", nm.get_id())
	print_debug("NavigationMap RID Id: ", wnm.get_id())


func _physics_process(delta):
#	if is_moving:
	if _NavAgentNode.is_navigation_finished():
		return

	var targetpos = _NavAgentNode.get_next_location()
	var direction = global_transform.origin.direction_to(targetpos)
	var velocity = direction * movement_speed # _NavAgentNode.max_speed

#	var velocity = (MoveToThisPosition - transform.origin).normalized() * _NavAgentNode.max_speed * delta
#	_NavAgentNode.set_velocity(velocity)

	var mas = move_and_slide(velocity, Vector3.UP)
	print_debug("NextTarget : ", targetpos)
	print_debug("Global Transform: ", global_transform.origin)


#	var velocity = (MoveToThisPosition - transform.origin).normalized() * speed * delta

#		$Unit.move_and_collide(velocity)


func _on_NavigationAgent_velocity_computed(_safe_velocity: Vector3) -> void:
#		move_and_slide(_safe_velocity)
	var mas = move_and_slide(_safe_velocity, Vector3.UP)
	print_debug("Global Transform: ", global_transform.origin)
#	pass # Replace with function body.


func SetAgentTarget(newAgentTarget:Vector3)-> void:
	print_debug("SetAgentTarget: %s" % newAgentTarget)
	_NavAgentNode.set_target_location(newAgentTarget)
#	print_debug("get_navigation_map(): %s" % _NavAgentNode.get_navigation_map().get_id())
#	var nm = _NavAgentNode.get_navigation_map()
#	var reachable = _NavAgentNode.is_target_reachable()
##	if reachable:
#	print_debug("is_target_reachable(): %s" % reachable)
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
#	is_moving = true
#	TODO: Dummy für Nav Punkte erstellen
	var path = _NavAgentNode.get_nav_path()

	if path.size() > 0:
		if _NavPointNodeParent.get_child_count() > 0:
			for c in _NavPointNodeParent.get_children():
				c.queue_free()
		for p in path:
			var nav = NavPoint.instance()
			nav.translate(p)
			_NavPointNodeParent.add_child(nav)


	pass # Replace with function body.


func _on_NavigationAgent_target_reached():
#	is_moving = false
	pass # Replace with function body.


func _on_NavigationAgent_navigation_finished():
	print_debug("_on_NavigationAgent_navigation_finished()")

#	pass # Replace with function body.
