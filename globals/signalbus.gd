extends Node


# GameManager
# warning-ignore:unused_signal
signal setgamemanagerinstance(GMInstance)
# warning-ignore:unused_signal
signal game_manager_is_ready

# ObjectManager
# warning-ignore:unused_signal
signal objectselected
# warning-ignore:unused_signal
signal objectunselected

# Building
# warning-ignore:unused_signal
signal add_newobject_tobuildqueue(newtype, Building_ID)
# warning-ignore:unused_signal
signal newobject_build_has_started(Building_ID)
# warning-ignore:unused_signal
signal newobject_instantiated(newtype, Building_ID)
# warning-ignore:unused_signal

# Helper
# warning-ignore:unused_signal
signal scene_end_reached
