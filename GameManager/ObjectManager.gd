class_name ObjectManager
extends Node

# ===========================
# Manager der als Proxy zwischen interagierbaren Objekten steht
# Hier wird ermittelt welches Objekt eine AKtion ausführt
# und leitet diese weiter
# ===========================

signal objectselected
signal objectunselected

# ===========================
func _init():
	print("ObjectManager Created")
	if !is_connected("objectselected", self, "_on_select_object"):
		var conn = connect("objectselected", self, "_on_select_object")
		assert(conn, "Connect von Signal objectselected gescheitert")
	if !is_connected("objectunselected", self, "_on_unselect_object"):
		var conn = connect("objectunselected", self, "_on_unselect_object")
		assert(conn, "Connect von Signal objectunselected gescheitert")
	pass


func _ready():
	pass


func _enter_tree():
	pass


func _exit_tree():
	pass

# ===========================
# Signal ein Objekt deselektieren
func _on_unselect_object() -> void:
# TODO: ObjectTyp ermitteln, Selektiertes aktives Objekt Selection aufheben, Selection in Object deaktivieren
	pass

# Signal ein Objekt selektieren
func _on_select_object(_selectedobject) -> void:
# TODO: ObjectTyp ermitteln, aktives selectiertes Object setzen, Selection in Object aktivieren
	pass
# ===========================
# ===========================
