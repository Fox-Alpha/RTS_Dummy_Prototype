extends Control
# TODO: Verbinden mit Building Manager
# Verbinden mit UnitManager
# Unit Asset abrufen
# Unit erzeugen im Unitmanager

var GM : GameManager
var selection: int = 0

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
	var t: Timer = get_node("CooldownTimer")
	if t.is_stopped():
		selection = arg_1
		get_node("%TextureProgress").value = 0
		t.start()
	pass # Replace with function body.


func _on_TextureButton_color_pressed(extra_arg_0):
	pass # Replace with function body.


func _Set_GameManager_Instance():
	GM = Globals.get_gamemanager_instance()
	print(name, "::SetGameManagerInstance() -> ", name)


func _on_Timer_timeout():
	var pb = .get_node("%TextureProgress")	#ColorRect/PanelContainer/VBoxContainer/Panel/VBoxContainer/
	pb.value += 1
	if pb.value == pb.max_value:
		.get_node("CooldownTimer").stop()
		# -> SignalNeues Object erstellen
		emit_signal("Instantiatenewobject", selection)
		# -> Angabe von Auswahl
		# -> OM: Ermitteln des selktierten Typs (Building)
		# -> OM: an selectedobject: Instanziere neus Object von Typ [AUswahl]
	pass # Replace with functionC body.
