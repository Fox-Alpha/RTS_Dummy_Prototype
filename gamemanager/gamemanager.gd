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
export var Managers : Dictionary = {}
onready var camera = .get_viewport().get_camera()

const GROUND_PLANE = Plane(Vector3.UP, 0)

# TODO: Dynamich durch die Node selber registrieren
onready var UnitsNode = $"../World/Units"

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
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
		_select_object()
	# TODO: Ignorieren wenn die SHIFT Taste mitgedrückt wird. Soll die Kamera beegen
	if event.is_action_pressed("MouseClickRightButton", true):
		_last_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("MouseClickRightButton", true):
#		if event.is_action_released("camera_pan"):
#		var mspeed = _get_mouse_speed()
		if _get_mouse_speed() == Vector2.ZERO:
			_navigate_object()
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
func _get_collider_at_mouse_position():
	var spaceSTate = .get_tree().get_root().get_world().direct_space_state
	var mousePos = .get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceSTate.intersect_ray(rayOrigin, rayEnd)

	return rayArray


func getmouseposin3d():
	var position2D = .get_viewport().get_mouse_position()
	var position3D = GROUND_PLANE.intersects_ray(camera.project_ray_origin(position2D),camera.project_ray_normal(position2D))

	return position3D


# ===========================
# Lokale Methoden
# ===========================
func _navigate_object() -> void:
	var rayArray = _get_collider_at_mouse_position()
	getmouseposin3d()

	if rayArray.has("collider"):
		printt(rayArray)
		var collider = rayArray["collider"]
		var colliderparent:Spatial = collider.get_parent_spatial()

		if is_instance_valid(colliderparent):
			if colliderparent.has_method("get_objecttype"):
				var objType = colliderparent.call("get_objecttype")

				if objType == Globals.OBJECT_TYPE_ENUM.TYPE_GROUND:
					var objectmanager_id = get_manager_instance("ObjectManager")
					if objectmanager_id > 0:
						var om = instance_from_id(objectmanager_id)
						
						if is_instance_valid(om):
							var so = om.selected_object
							if is_instance_valid(so) and so.call("get_objecttype") == Globals.OBJECT_TYPE_ENUM.TYPE_UNIT:
								so.SetAgentTarget(getmouseposin3d())
							if is_instance_valid(so) and so.call("get_objecttype") == Globals.OBJECT_TYPE_ENUM.TYPE_BUILDING:
								so.SetBuildingRallyPoint(getmouseposin3d())



# Wenn Collision hat "canSelected", dann per Type an Manager weiterleiten
func _select_object() -> void:
	var rayArray = _get_collider_at_mouse_position()

	if rayArray.has("collider"):
		printt(rayArray)
		var collider = rayArray["collider"]

		if !collider.has_method("get_objecttype"):
				collider = collider.get_parent_spatial()
		if is_instance_valid(collider):
			var cansel = collider.call("can_objectselected")
			if cansel:
				print_debug("GM::_select_object() ->  Signal objectselected emitted")
				Signalbus.emit_signal("objectselected", collider)
			else:
				Signalbus.emit_signal("objectunselected")


# ===========================
# public Methoden
# ===========================
# Von einem bestimmten Manager die aktuelle Instanz abholen
func get_manager_instance(manager : String) -> int:	# -> Manager Instanz ID
	if Managers.has(manager):
		return Managers[manager]
	return -1


func BroadCastGM():
	if Managers.size() > 0:
		for m in Managers:
			if Managers[m].has_method("SetGameManagerInstance"):
				Managers[m].SetGameManagerInstance()
