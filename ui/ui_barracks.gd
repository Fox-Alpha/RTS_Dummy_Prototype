extends Control

var GM : GameManager
var UIM : UIManager

export var is_building = false
export var selection: int = 0
export var buildtime : float = 1.0	# ms
export var elapsedbuildtime = 0
export var active_Building_ID = -1


onready var button = preload("res://ui/ButtBuildUnit.tscn")
onready var ButtGrid = $"%GridButtonUnitContainer"
onready var ButtQueue = $"%GridButtonQueueContainer"


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	if !Signalbus.is_connected("game_manager_is_ready", self, "_on_game_manager_is_ready"):
		var _sig = Signalbus.connect("game_manager_is_ready", self, "_on_game_manager_is_ready")

	# # Signal um das UI zu aktualisieren, ICON für Warteschlange
#	if !Signalbus.is_connected("newobject_tobuildqueue_added", self, "_on_newobject_tobuildqueue_added"):
#		var _sig = Signalbus.connect("newobject_tobuildqueue_added", self, "_on_newobject_tobuildqueue_added")

	# Signal um das UI zu aktualisieren, Fortschritt der aktuellen Herstellung
	if !Signalbus.is_connected("newobject_build_advanced", self, "_on_newobject_build_advanced"):
		var _sig = Signalbus.connect("newobject_build_advanced", self, "_on_newobject_build_advanced")

	# Signal um das UI zu aktualisieren, Build beendet
	if !Signalbus.is_connected("newobject_build_has_endeded", self, "_on_newobject_build_has_endeded"):
		var _sig = Signalbus.connect("newobject_build_has_endeded", self, "_on_newobject_build_has_endeded")

	#signal newobject_buildqueue_updatet(Building_ID, queue)
	if !Signalbus.is_connected("newobject_buildqueue_updated", self, "_on_newobject_buildqueue_updated"):
		var _sig = Signalbus.connect("newobject_buildqueue_updated", self, "_on_newobject_buildqueue_updated")

#func _enter_tree():
#	pass


#func _exit_tree():
#	pass

# ===========================


# ===========================

func _on_TextureButton_pressed(arg_1:int):
	Signalbus.emit_signal("newobject_tobuildqueue_added", arg_1, active_Building_ID)


func _on_newobject_buildqueue_updated(queue:Array, buildingid:int):
	# DONE: Add Icon (Button) for Queue to second Panel
	if buildingid == active_Building_ID:
		if UIM._objectui_properties.size() > 0 :
			if ButtQueue.get_child_count() > 0:
				for q in ButtQueue.get_children():
					q.queue_free()
			if queue.size() > 0:
				var UnitsToBuild:Dictionary = UIM._objectui_properties.get("ObjectsToSpawn")
				for unittype in queue:
					if UnitsToBuild.has(str(unittype)):
						var b:Panel = button.instance(1)
						# var tbuc:TextureButton = b.get_node("TextureButtUnitColor")
						b.get_node("LabelUnitName").text = UnitsToBuild[str(unittype)].name
						b.get_node("TextureButtUnitColor").self_modulate = UnitsToBuild[str(unittype)].color
						b.name = "BuildQueue_%s" % UnitsToBuild[str(unittype)].name
						
						# TODO: Cancel Event erstellen
		#					if not tbuc.is_connected("pressed", self, "_on_TextureButton_pressed"): 
		#						var _ccn =tbuc.connect("pressed", self, "_on_TextureButton_pressed", [u.to_int()])
						
						ButtQueue.add_child(b)

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


func _on_newobject_build_advanced(ui_id:int, progress:float):
	if ui_id == get_instance_id() and visible == true:
		var tp = get_node("%TextureProgress")
		if is_instance_valid(tp):
			tp.value = progress


func _on_newobject_build_has_endeded(buildingid:int, progress:float):
	if buildingid == active_Building_ID:
		var tp = get_node("%TextureProgress")
		if is_instance_valid(tp):
			tp.value = progress
		# ADDME: Visuelle Warteschlange aktualisieren
