extends Control

var GM : GameManager
var UIM : UIManager

export var is_building = false
export var selection: int = 0
export var buildtime : float = 1.0	# ms
export var elapsedbuildtime = 0
export var active_Building_ID = -1


onready var button = preload("res://ui/ButtBuildUnit.tscn")
onready var ButtGrid = $"%GridButtonContainer"


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	if !Signalbus.is_connected("game_manager_is_ready", self, "_on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "_on_game_manager_is_ready")

	# Signal um das UI zu aktualisieren, Fortschritt der aktuellen Herstellung
	# if !Signalbus.is_connected("", self, ""):
	# 	var _sig = Signalbus.connect("", self, "")

	# # Signal um das UI zu aktualisieren, ICON für Warteschlange
	if !Signalbus.is_connected("newobject_tobuildqueue_added", self, "_on_newobject_tobuildqueue_added"):
		var _sig = Signalbus.connect("newobject_tobuildqueue_added", self, "_on_newobject_tobuildqueue_added")


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# ===========================


# ===========================

func _on_TextureButton_pressed(arg_1:int):
	# TODO: Button zur Warteschlange hinzufügen
	Signalbus.emit_signal("newobject_tobuildqueue_added", arg_1, active_Building_ID)


	# TODO: Warteschlange im UI aktualisieren
	# Warteschlange aus selectedobject lesen und anzeigen
#	match arg_1:
#		1:	# Unit RED
#			pass
#		2:	# Unit YELLOW
#			pass
#		3:	# Unit GREEN
#			pass
#		4:	# Unit BLUE
#			pass
			
	# var tp = get_node("%TextureProgress")
	# if is_instance_valid(tp) and not is_building:
	# 	selection = arg_1
	# 	var pop = UIM._objectui_properties
	# 	buildtime = pop["ObjectsToSpawn"][String(selection)]["buildtime"]
		
	# 	if tween.interpolate_property(
	# 		tp, "value", tp.min_value, tp.max_value,
	# 		buildtime, Tween.TRANS_SINE, Tween.EASE_OUT
	# 		):
	# 		tween.start()
	# else:
			
func _on_newobject_buildqueue_progressed(progress):
	var tp = get_node("%TextureProgress")
	if is_instance_valid(tp):
		tp.value = progress


func _on_newobject_tobuildqueue_added(_unittype:int, _buildingid:int):
	# TODO: Add Icon for Queue to second Panel
	pass

func _on_game_manager_is_ready():
	GM = Globals.GMInstance
	var ui_manager_id  = GM.get_manager_instance("UIManager")
	UIM = instance_from_id(ui_manager_id)
		

func _on_UI_Barracks_visibility_changed() -> void:
	if !visible:
		return

	if UIM._objectui_properties.size() > 0:
		var UnitsToBuild:Dictionary = UIM._objectui_properties.get("ObjectsToSpawn")
		if ButtGrid.get_child_count() > 0:
			for c in ButtGrid.get_children():
				c.queue_free()
		if UnitsToBuild.size() > 0:
			for u in UnitsToBuild.keys():
				var b:Panel = button.instance()
				var tbuc:TextureButton = b.get_node("TextureButtUnitColor")
				b.get_node("LabelUnitName").text = UnitsToBuild[u].name
				b.get_node("TextureButtUnitColor").self_modulate = UnitsToBuild[u].color
				b.name = "Build_%s" % UnitsToBuild[u].name

				if not tbuc.is_connected("pressed", self, "_on_TextureButton_pressed"): 
					var _ccn =tbuc.connect("pressed", self, "_on_TextureButton_pressed", [u.to_int()])

				ButtGrid.add_child(b)
		
		active_Building_ID = UIM._objectui_properties.get("ObjectInstanceID")


# func _on_Tween_tween_started(_object: Object, _key: NodePath) -> void:
# 	is_building = true
# 	Signalbus.emit_signal("add_newobject_tobuildqueue", selection, active_Building_ID)
# 	Signalbus.emit_signal("newobject_build_has_started", active_Building_ID)


# func _on_Tween_tween_all_completed() -> void:
# 	is_building = false
	# tween.tell()


# func _on_Tween_tween_step(_object:Object, _key:NodePath, _elapsed:float, _value:Object):
# 	pass # Replace with function body.
