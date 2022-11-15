extends Control
# TODO: Verbinden mit Building Manager
# Verbinden mit UnitManager
# Unit Asset abrufen
# Unit erzeugen im Unitmanager

var GM : GameManager
export var selection: int = 0
export var buildtime : float = 5.0	# ms
export var elapsedbuildtime = 0

onready var timernode = get_node("CooldownTimer")
onready var tween = $"Tween"

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
	if is_instance_valid(tp):
		tween.interpolate_property(
			tp, "value", tp.min_value, tp.max_value,
			buildtime, Tween.TRANS_SINE, Tween.EASE_OUT
		)
	tween.start()
	
	yield(tween, "tween_all_completed")
	print_debug("Tween beendet")
#	var t: Timer = get_node("CooldownTimer")
#	if t.is_stopped():
#		selection = arg_1
#		get_node("%TextureProgress").value = 0
##		get_node("%TextureProgress").max_value = buildtime
#		elapsedbuildtime = 0
#		t.start()
#	pass # Replace with function body.


func _on_TextureButton_color_pressed(extra_arg_0):
	pass # Replace with function body.


func _Set_GameManager_Instance():
	GM = Globals.get_gamemanager_instance()
	print(name, "::SetGameManagerInstance() -> ", name)


func _on_Timer_timeout():
	var pb = .get_node("%TextureProgress")	#ColorRect/PanelContainer/VBoxContainer/Panel/VBoxContainer/
	elapsedbuildtime += timernode.wait_time *1000
	var elapsed = elapsedbuildtime * 100 / buildtime
	pb.value = elapsed
	var p = pb.value
	var m = pb.max_value
	if pb.value >= pb.max_value:
		.get_node("CooldownTimer").stop()
		# -> SignalNeues Object erstellen
		Signalbus.emit_signal("newobject_instantiated", selection)
		# -> Angabe von Auswahl
		# -> OM: Ermitteln des selktierten Typs (Building)
		# -> OM: an selectedobject: Instanziere neus Object von Typ [AUswahl]
	pass # Replace with functionC body.
