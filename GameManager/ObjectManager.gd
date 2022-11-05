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
	connect("objectselected",Callable(self,"_on_select_object"))
	connect("objectunselected",Callable(self,"_on_unselect_object"))
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
#	selected_object = null
	pass

# Signal ein Objekt selektieren
func _on_select_object(_selectedobject) -> void:
	
	pass
# ===========================
# ===========================
