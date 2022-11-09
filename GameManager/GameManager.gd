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
# TODO: GameManager Instanz per GLOBALS zur Verfügung stellen
# ====: Evtl. ein eigenes Autoload erstellen ?

export var Managers : Dictionary = {}
onready var camera = .get_viewport().get_camera()


func _init():
	pass


func _ready():
	print("GameManager::_ready() -> Created")
	var manager = .get_children()

	if manager.size() > 0:
		for m in manager:
			var managerinstance = m 
			if managerinstance != null:
				Managers[m.name] = managerinstance

				if managerinstance.has_method("init_signals"):
					managerinstance.init_signals()

	Signalbus.emit_signal("setgamemanagerinstance", self)


# func _enter_tree():
#	pass


# func _exit_tree():
# 	pass


func _input(_event) -> void:
	# Mousevent Left and Right Button here
	if Input.is_action_just_pressed("MouseClickLeftButton", true):
		_select_object()
	if Input.is_action_just_pressed("MouseClickRightButton", true):
		_navigate_object()


func _get_collider_at_mouse_position():
	var spaceSTate = .get_tree().get_root().get_world().direct_space_state
	var mousePos = .get_viewport().get_mouse_position()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceSTate.intersect_ray(rayOrigin, rayEnd)

	return rayArray


func _navigate_object() -> void:
	var rayArray = _get_collider_at_mouse_position()

	if rayArray.has("collider"):
		printt(rayArray)
		var collider = rayArray["collider"]
		var colliderparent:Spatial = collider.get_parent_spatial()

		if is_instance_valid(colliderparent):
			if colliderparent.has_method("get_objecttype"):
				var objType = colliderparent.call("get_objecttype")
				print_debug("_navigate_object(): ", objType)
				if objType == Globals.OBJECT_TYPE_ENUM.TYPE_GROUND:
					var om = get_manager_instance("ObjectManager")
					if is_instance_valid(om):
						print_debug(om)
						var so = om.selected_object
						if is_instance_valid(so):
							so.SetAgentTarget(Vector3(0.0, 0.0, 0.0))



# Wenn Collision hat "canSelected", dann per Type an Manager weiterleiten
func _select_object() -> void:
	var rayArray = _get_collider_at_mouse_position()

	if rayArray.has("collider"):
		printt(rayArray)
		var collider = rayArray["collider"]
		var colliderparent:Spatial = collider.get_parent_spatial()

		if is_instance_valid(colliderparent):
			if colliderparent.call("can_objectselected"):
				Signalbus.emit_signal("objectselected", colliderparent)
			else:
				Signalbus.emit_signal("objectunselected")


# Von einem bestimmten Manager die aktuelle Instanz abholen
func get_manager_instance(manager : String) -> UnitManager:
	if Managers.has(manager):
		return Managers[manager]
	return null

