#class_name Template_Script

#const Template = preload("res://Script_Templates/Template_Script.gd")

#Nutze die Vergangenheitsform um Signale zu benennen:
#
#signal door_opened
#signal score_changed

#Verwende CONSTANT_CASE, alles in Großbuchstaben, mit einem Unterstrich zur Worttrennung:
#const CONSTAND_VAR = 200:

#Verwenden Sie PascalCase für Aufzählungsnamen und CONSTANT _CASE für deren Mitglieder, da es sich um Konstanten handelt:

# enum Element {
#    EARTH,
#    WATER,
#    AIR,
#    FIRE,
#}

#-------------------------------------------------------------------------------

#01. tool
#02. class_name
#03. extends
#04. # docstring
#
#05. signals
#06. enums
#07. constants
#08. exported variables
#09. public variables
#10. private variables
#11. onready variables
#
#12. optional built-in virtual _init method
#13. built-in virtual _ready method
#14. remaining built-in virtual methods
#15. public methods
#16. private methods

#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
#tool
#class_name
extends %BASE%
# Eine Vorlage für neue Scripte
#-------------------------------------------------------------------------------
# Signals
#-------------------------------------------------------------------------------
# enums
#-------------------------------------------------------------------------------
# constants
#-------------------------------------------------------------------------------
# exported variables
#-------------------------------------------------------------------------------
# private variables
#-------------------------------------------------------------------------------
# onready variables
#onready var myVar: string
#-------------------------------------------------------------------------------
# optional built-in virtual _init method
#-------------------------------------------------------------------------------
# built-in virtual _ready method
#-------------------------------------------------------------------------------
# remaining built-in virtual methods
func _ready() -> void:
	pass
#-------------------------------------------------------------------------------
# public methods
#-------------------------------------------------------------------------------
# private methods
#-------------------------------------------------------------------------------

