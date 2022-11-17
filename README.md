# RTS_Dummy_Prototype
Prototype zum entwickeln der benötigten Logic für ein RTS Game Projekt

Sandbox zum entwickeln verschiedenen Spielelemente:
Es geht nur um Prototypen, nicht um ein fertiges Spiel. 
Ebenso werden keine aufwendigen Assets verwendet. Wenn möglich werden Simple Meshes verwendet.

~~Am ende soll mindestens ein MVP "Minimum Viable PRototype" entstehen.~~

Das ganze wird wohl mehr als nur ein minimum Prototype.
Es wird keine Anleitungen oder Tutorials geben.

Und auch nur ungeplante Downloads.

---

Entwickelt wird mit der Godotengine 3.51 Stable unter Windows

Bei weiteren voranschreiten der Godot 4 Beta Versionen wird auch hier die Konvertierung der Scripte "geprobt"

Folgende Punkte sind mir am wichtigsten:
> Strukturierung des Projektes
  > Projektplanung und Organisation
  > Nutzung zusätzlicher Tools wie zum Beispiel Github Issues und Projekte.
  > Dokumentation
  > Game Design Dokument
> Kamera Steuerung wie aus den meisten RTS Spielen bekannt
> Einheiten Steuern per Auswahl und dann Point'n Click zum Steuern
> Einheiten in Gebäuden herstellen und diese Managen
> Die benötigte Game Logik aufbauen Stichwort Game Manager Scripte
> Multiplayer Verbinden mit mind. 2 Clients. Vorgehen Spielerhosting aber Server hat Authorität
  > Synchronisieren der Spieler


Bis jetzt habe ich bereits einige Mechaniken umgesetzt, oder ich bin dabei (Stand: 17.11.2022)

> Eine Kamera Steuerung im RTS Style. Noch nicht enthalten ist das Scrollen am Bildrand. 
  > Die Steuerung ist noch nicht optimal, aber in den Grundzügen implementiert
> "Einheiten" können selektiert werden und mit einem rechtsklick gesteuert werden
> "Gebäude" können selektiert werden und bieten eine UI an.
> In einem selektiertem Gebäude kann der Sammelpunkt per rechtsklick gesetzt werden.
> In der Gebäude UI können bereits Einheiten hergestellt werden
  > Es gibt auch eine kleine Animation die den Fortschritt zeigt
  > Es können unterschiedliche Einheiten ausgewählt werden. Bis auf die Farbe unterscheiden die sich allerdings noch nicht wirklich
    > Im Hintergrund gibt es allerdings schon weitere Eigenschaften
	
Aktuell arbeite ich an einem Warteschlangensystem beim Bau von Einheiten.


Anschließend werde ich mich nochmal der Navigation widmen. Hier kommt es noch zu dem Verhalten das die NavigationAgents andere Agents ignorieren und ihren Pfad nicht anpassen.
Dann werde ich mich auch endlich dem Netzwerk und somit dem Multiplayer annehmen.