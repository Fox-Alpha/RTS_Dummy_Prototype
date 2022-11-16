extends Control
# TODO: Verbinden mit Building Manager
# Verbinden mit UnitManager
# Unit Asset abrufen
# Unit erzeugen im Unitmanager

var GM : GameManager
var UIM : UIManager
var is_building = false

export var selection: int = 0
export var buildtime : float = 1.0	# ms
export var elapsedbuildtime = 0

onready var tween = $"Tween"
onready var button = preload("res://ui/ButtBuildUnit.tscn")
onready var ButtGrid = $"%GridButtonContainer"


# ===========================
# Build-In Methoden
# ===========================
#func _init():
#	pass


func _ready():
	_Set_GameManager_Instance()


#func _enter_tree():
#	pass


#func _exit_tree():
#	pass
# ===========================
# TODO: Abrufen des Property Dictionary 
# TRYME: Build Anforderung an aufrufer senden
# ===========================

func _on_TextureButton_pressed(arg_1:int):
	match arg_1:
		1:	# Unit RED
			pass
		2:	# Unit YELLOW
			pass
		3:	# Unit GREEN
			pass
		4:	# Unit BLUE
			pass
			
	var tp = get_node("%TextureProgress")
	if is_instance_valid(tp) and not is_building:
		if tween.interpolate_property(
			tp, "value", tp.min_value, tp.max_value,
			buildtime, Tween.TRANS_SINE, Tween.EASE_OUT
			):
			selection = arg_1
			tween.start()


func _on_TextureButton_color_pressed(_extra_arg_0):
	pass # Replace with function body.


func _Set_GameManager_Instance():
	GM = Globals.get_gamemanager_instance()
	print(name, "::SetGameManagerInstance() -> ", name)
	UIM = GM.get_manager_instance("UIManager")


func _on_UI_Barracks_visibility_changed() -> void:
	if !visible:
		return
	# TODO: Empfangene Properties auswerten
	if UIM._objectui_properties.size() > 0:
		var UnitsToBuild:Dictionary = UIM._objectui_properties.get("ObjectsToSpawn")
		if ButtGrid.get_child_count() > 0:
			for c in ButtGrid.get_children():
				c.queue_free()
		if UnitsToBuild.size() > 0:
			for u in UnitsToBuild.keys():
				var b:Panel = button.instance()
				b.get_node("LabelUnitName").text = UnitsToBuild[u].name
				b.get_node("TextureButtUnitColor").self_modulate = UnitsToBuild[u].color
				var m = b.get_node("TextureButtUnitColor").modulate
				b.name = "Build_%s" % UnitsToBuild[u].name
				ButtGrid.add_child(b)
	# Buttons dynamisch nach : ObjectsToSpawn erstellen
	# Signals mit Parameter verknüpfen
	pass # Replace with function body.


func _on_Tween_tween_started(_object: Object, _key: NodePath) -> void:
	is_building = true
	pass # Replace with function body.


func _on_Tween_tween_all_completed() -> void:
	is_building = false
	Signalbus.emit_signal("newobject_instantiated", selection)
	pass # Replace with function body.
