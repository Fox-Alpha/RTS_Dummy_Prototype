@echo off
cd C:\Proggen\Godot\Godot_v3.5.1-stable_win64
Godot_v3.5.1-stable_win64.exe --verbose --export-debug "Windows Desktop" --path "C:\Proggen\Godot\Projekte\RTS_Dummy_Prototype" "C:\Proggen\Godot\Projekte\Export\RTS_Dummy_Prototype\RTS_Dummy_Prototype.exe" > "C:\Proggen\Godot\Projekte\Export\RTS_Dummy_Prototype\export.log.txt"

cd C:\Proggen\Godot\Projekte\Export\RTS_Dummy_Prototype
RTS_Dummy_Prototype.exe


cd C:\Proggen\Godot\Projekte\RTS_Dummy_Prototype\cli_export