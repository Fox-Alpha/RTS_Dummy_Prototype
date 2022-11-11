REM @echo off
:: P:\SteamLibrary\steamapps\common\Godot Engine>
REM godot.windows.opt.tools.64.exe --verbose --export-debug "Windows Desktop" --test gui --path "P:\3. GODOT Projekte\Projekte\Just4Fun_Mini_Shootergame" "P:\3. GODOT Projekte\Projekte\Just4Fun_Mini_Shootergame\.Export\MiniShooter.exe" > "P:\3. GODOT Projekte\Projekte\Just4Fun_Mini_Shootergame\.export\export.txt"

REM cd C:\Proggen\Godot\Godot_v3.5.1-stable_win64
p: & cd P:\SteamLibrary\steamapps\common\Godot Engine
godot.windows.opt.tools.64.exe --verbose --export-debug "Windows Desktop" --path "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git" "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\.export\RTS_Dummy_Prototype.exe" > "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\.export\export.log.txt"

cd "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\.export"
RTS_Dummy_Prototype.exe


cd "P:\3. GODOT Projekte\Projekte\Fortify-Inspired-Jam\Prototypes\3.5x\RTS_Dummy_Prototype.git\cli_export"

