extends Node


#
#	Verwaltung der einzelnen Karten Ansichten der Spieler

# Jeder Spieler hat die gleiche Karte in der er seine Einheiten steuern kann
# Schickt einer der Spieler einen Angriffs Trupp zum Gegner ist es ihm unter bestimmten voraussetzungen 
# Möglich (TechTreeUpgrade) Auf die Karte des anderen Spielers zu schauen und einfluss auf seinen Angriff 
# zu nehmen.

# Dazu ist es notwendig das seine Kamera die Karte des anderen Spielers anzeigt.

# Dieser Manager ist ebenfalls dafür zuständig das die Karten Identische bei Start generiert werden.
# Zusammen mit dem NetworkManager wird diese bei allen Spielern Synchronisiert

# Über einen Worldseed soll es möglich sein eine Karte jederzeit bei Spielstart wieder neu zu generieren.



func _init():
	print("WorldManager::_init() -> Created")
	pass


#func _ready():
#	pass


func _enter_tree():
	pass


func _exit_tree():
	pass
