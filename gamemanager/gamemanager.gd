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
# TODO: Aufräumen Linksklick
# TODO: Aufräumen Rechtsklick
# ===========================
export var Managers : Dictionary = {}
onready var camera = .get_viewport().get_camera()

const GROUND_PLANE = Plane(Vector3.UP, 0)

# TODO: Dynamich durch die Node selber registrieren, siehe Ground
onready var UnitsNode = $"../World/Units"

var GroundNodeID:int setget _set_groundnode_id, _get_groundnode_id
var UnitsNodeID:int setget _set_unitsnode_id, _get_unitsnode_id

var _last_mouse_position = Vector2()
# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	var manager = .get_children()

	if manager.size() > 0:
		for m in manager:
			var managerinstance = m
	
			if is_instance_valid(managerinstance):
				Managers[m.name] = managerinstance.get_instance_id()

				if managerinstance.has_method("init_signals"):
					managerinstance.init_signals()

	Signalbus.emit_signal("setgamemanagerinstance", self)


# func _enter_tree():
#	pass


# func _exit_tree():
# 	pass


func _input(event) -> void:
	# Mousevent Left and Right Button here
	# ADDME: left_clicked left_released and Drag for Multiselect
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
#		_select_object()
		var rayArray = _get_collider_at_mouse_position()
		if rayArray.has("collider"):
			Signalbus.emit_signal("objectleftclicked", rayArray["collider_id"])

	if event.is_action_pressed("MouseClickRightButton", true):
		_last_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("MouseClickRightButton", true):
#		if event.is_action_released("camera_pan"):
#		var mspeed = _get_mouse_speed()
		if _get_mouse_speed() == Vector2.ZERO:
#			_navigate_object()
			var rayArray = _get_collider_at_mouse_position()
			if rayArray.has("collider"):
				Signalbus.emit_signal("objectrightclicked", rayArray["collider_id"], _get_mouseposition_3d())

# ===========================

func _get_mouse_speed() -> Vector2:
	# calculate speed
	var current_mouse_pos = get_viewport().get_mouse_position()
	var mouse_speed = current_mouse_pos - _last_mouse_position
	# update last click position
	_last_mouse_position = current_mouse_pos
	# return speed
	return mouse_speed

# ===========================
# Helper Methoden
# ===========================
func _get_collider_at_mouse_position() -> Array:
	var spaceSTate = .get_tree().get_root().get_world().direct_space_state
	var mousePos = .get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceSTate.intersect_ray(rayOrigin, rayEnd)

	return rayArray


func _get_mouseposition_3d() -> Vector3:
	var position2D = .get_viewport().get_mouse_position()
	var position3D = GROUND_PLANE.intersects_ray(camera.project_ray_origin(position2D),camera.project_ray_normal(position2D))

	return position3D


# ===========================
# Lokale Methoden
# ===========================

func _set_groundnode_id(value):
	if is_instance_valid(instance_from_id(value)):
		GroundNodeID = value
	else:
		GroundNodeID = -1

func _get_groundnode_id():
	return GroundNodeID


func _set_unitsnode_id(value):
	if is_instance_valid(instance_from_id(value)):
		UnitsNodeID = value
	else:
		UnitsNodeID = -1


func _get_unitsnode_id():
	return UnitsNodeID
	
# ===========================
# public Methoden
# ===========================

# Von einem bestimmten Manager die aktuelle Instanz abholen
func get_manager_instance(manager : String) -> int:	# -> Manager Instanz ID
	if Managers.has(manager):
		return Managers[manager]
	return -1
