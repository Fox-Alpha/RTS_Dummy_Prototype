@echo off
:: P:\SteamLibrary\steamapps\common\Godot Engine>
REM godot.windows.opt.tools.64.exe --verbose --export-debug "Windows Desktop" --test gui --path "P:\3. GODOT Projekte\Projekte\Just4Fun_Mini_Shootergame" "P:\3. GODOT Projekte\Projekte\Just4Fun_Mini_Shootergame\.Export\MiniShooter.exe" > "P:\3. GODOT Projekte\Projekte\Just4Fun_Mini_Shootergame\.export\export.txt"

cd C:\Proggen\Godot\Godot_v3.5.1-stable_win64
Godot_v3.5.1-stable_win64.exe --verbose --export-debug "Windows Desktop" --test gui --path "C:\Proggen\Godot\Projekte\RTS_Dummy_Prototype" "C:\Proggen\Godot\Projekte\Export\RTS_Dummy_Prototype\RTS_Dummy_Prototype.exe" > "C:\Proggen\Godot\Projekte\Export\RTS_Dummy_Prototype\export.log.txt"

cd C:\Proggen\Godot\Projekte\Export\RTS_Dummy_Prototype
RTS_Dummy_Prototype.exe


cd C:\Proggen\Godot\Projekte\RTS_Dummy_Prototype