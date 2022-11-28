# RTS_Dummy_Prototype
Game Prototype zum entwickeln der benötigten RTS Steuerung und Logic für ein Game Projekt


Sandbox zum entwickeln verschiedenen Spielelemente wir zum Beispiel:
Es geht nur um Prototypen, nicht um ein fertiges Spiel. 
Ebenso werden keine aufwendigen Assets verwendet. Wenn möglich werden Simple Meshes verwendet.

Am ende soll mindestens ein MVP "Minimum Viable PRototype" entstehen.
Es wird keine Anleitungen oder Tutorials geben.

Und auch nur ungeplante Downloads.


- Steuerung
- GameManager Logik
- Multiplayer
- Kamera verhalten
- Object Verhalten
- etc.


Entwickelt wird mit der Godotengine 3.51 Stable unter Windows

Bei weiteren voranschreiten der Godot 4 Beta Versionen wird auch hier die Konvertierung der Scripte "geprobt"

Folgende Punkte sind mir am wichtigsten:
- Strukturierung des Projektes
- Kamera Steuerung wir aus den meisten RTS Spielen bekannt
- Einheiten Steuern per Auswahl und dann Point'n Click zum 
- Einheiten in Gebäuden herstellen und diese Managen
- Die benötigte Game Logik aufbauen Stichwort Game Manager Scripte
- Multiplayer Verbinden mit mind. 2 Clients. Vorgehen Spielerhosting aber Server hat Authorität
  - Synchronisieren der Spieler


## 28.11.2022 - Staging Developement Progress v0.0.1-alpha.1
Kleiner Meilenstein in der Entwicklung des Prototypen
Viele Funktionen sind nun Signal basiert.
U.a. Selection, Steuerung, UI Anzeige, Build Auswahl, Build Fortschritt, Instantierung neuer Einheiten.

Bis jetzt nur einfache Steuerung implementiert.

- RTS Kamera Steuerung
- Selektion von Einheiten und Gebäuden mit Linksklick.
- Setzen eines Zieles für Einheiten mit Rechtsklick
- Setzen eines neuen Sammelpunkt mit Rechtklick bei Gebäuden
- Gebäude zeigt eine UI mit einer Auswahl an Units die erstellt werden können
- Es wird ein Fortschritt angezeigt.


