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
var _instance:GameManager setget set_gamemanager_instance, get_gamemanager_instance

export var Managers : Dictionary = {}

export var selected_object = "" setget set_selectedobject, get_selectedobject


onready var camera = get_viewport().get_camera()


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
	print("GameManager _ready()")
#	_instance = GameManager.new()
	var manager = get_children()

	if manager.size() > 0:
		for m in manager:
			Managers[m.name] = m.get_script().new()
#
#		print_debug("Manager Dict: %s" % Managers)


func _enter_tree():
	pass


func _exit_tree():
	pass


func _input(_event) -> void:
	# Mousevent Left and Right Button here
	# Wenn Collision hat "canSelected", dann per Type an Manager weiterleiten
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
		_select_object()
	pass


func _select_object() -> void:
	var spaceSTate = get_tree().get_root().get_world().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
#	var ray = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
#	var rayArray = spaceSTate.intersect_ray(ray)
	var rayArray = spaceSTate.intersect_ray(rayOrigin, rayEnd)
	
	if rayArray.has("collider"):
		printt(rayArray)
		var collider = rayArray["collider"]
		if collider.get_parent_spatial():
			var colliderparent:Spatial = collider.get_parent_spatial()
#		if collider is KinematicBody:
##			var c = collider.get_children()
#			var NavAgent = collider.get_node("/root/Main/CharackterRoot/NavigationAgent")
#			if NavAgent != null:
#				if collider.get_parent_spatial().has_method("_select_unit") != false:
##					selectedUnit = collider
#					collider.get_parent_spatial()._select_unit(true)
#		el
			if colliderparent.has_node("ObjectType"):
				if colliderparent.get_node_or_null("%ObjectType").has_method("can_selected"):
					if colliderparent.can_selected():
						selected_object = colliderparent.get_parent_spatial()
						selected_object.selectobject()

# Von einem bestimmten Manager die aktuelle Instanz abholen
func get_manager_instance(manager : String) -> UnitManager:
	if Managers.has(manager):
		return Managers[manager]
	
	return null




#set_selectedobject, get_selectedobject
func set_selectedobject(value) -> void:
	if value != value.empty():
		selected_object = value


func get_selectedobject():
	return selected_object