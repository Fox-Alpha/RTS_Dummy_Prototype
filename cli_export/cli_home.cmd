@echo off
p: & cd P:\SteamLibrary\steamapps\common\Godot Engine
godot.windows.opt.tools.64.exe --verbose --export-debug "Windows Desktop" --path "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git" "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\.export\RTS_Dummy_Prototype.exe" > "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\.export\export.log.txt"

cd "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\.export"
RTS_Dummy_Prototype.exe


cd "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\cli_export"