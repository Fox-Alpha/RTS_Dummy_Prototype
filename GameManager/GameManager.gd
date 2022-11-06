extends ManagerBase
class_name GameManager

# ===========================
# Dies ist der Hauptmanager der mit den anderen Managern kommuniziert
# Es werden globale Ereignisse an den richtigen Manager weitergeleitet
# 
# z.B. Tastatureingaben und Maussteuerung
# 
# Speichern des laufenden Spiels (Autosave)
# 
# Starten und Beenden eines Spiels
# 
# Starten und Managen des Netzwerkmodus
# 
# ===========================
# get_class()
# is_class() 
# is_CustomClass()
# ===========================
signal objectselected
signal objectunselected

var _instance:GameManager setget set_gamemanager_instance, get_gamemanager_instance

export var Managers : Dictionary = {}
onready var camera = .get_viewport().get_camera()


func set_gamemanager_instance(_value):
#	if value != null && _instance == null:
#		_instance = value
	pass


func get_gamemanager_instance():
#	return _instance
	pass


func _init():
	pass


func _ready():
	print("GameManager::_ready() -> Created")
	
#	_instance = GameManager.new()
	var manager = .get_children()

	if manager.size() > 0:
		for m in manager:
			var managerinstance = m #.get_script().new()
			if managerinstance != null:
				Managers[m.name] = managerinstance
#				print_debug(managerinstance.get_script_method_list())

				if managerinstance.has_method("init_signals"):
					managerinstance.GMInstance = self #.get_script()
					managerinstance.init_signals()


# func _enter_tree():
#	pass


# func _exit_tree():
# 	pass


func _input(_event) -> void:
	# Mousevent Left and Right Button here
	# Wenn Collision hat "canSelected", dann per Type an Manager weiterleiten
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
		_select_object()
	pass


func _select_object() -> void:
	var spaceSTate = .get_tree().get_root().get_world().direct_space_state
	var mousePos = .get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
#	var ray = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
#	var rayArray = spaceSTate.intersect_ray(ray)
	var rayArray = spaceSTate.intersect_ray(rayOrigin, rayEnd)
	
	if rayArray.has("collider"):
		printt(rayArray)
		var collider = rayArray["collider"]
		var colliderparent:Spatial = collider.get_parent_spatial()

		if is_instance_valid(colliderparent):
			if colliderparent.call("can_selected"):
				.emit_signal("objectselected", colliderparent)

#			if colliderparent.has_node("ObjectType"):
#				var objType = colliderparent.get_node_or_null("%ObjectType")
#				if objType.has_method("can_selected"):
#					if objType.can_selected():
#		if collider is KinematicBody:
##			var c = collider.get_children()
#			var NavAgent = collider.get_node("/root/Main/CharackterRoot/NavigationAgent")
#			if NavAgent != null:
#				if collider.get_parent_spatial().has_method("_select_unit") != false:
##					selectedUnit = collider
#					collider.get_parent_spatial()._select_unit(true)
#		el



# Von einem bestimmten Manager die aktuelle Instanz abholen
func get_manager_instance(manager : String) -> UnitManager:
	if Managers.has(manager):
		return Managers[manager]
	return null

