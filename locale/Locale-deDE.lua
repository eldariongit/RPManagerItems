local L = LibStub("AceLocale-3.0"):NewLocale("RPManagerItems", "deDE")
if not L then return end

--[[
Umlautersetzung: Unicode for deutsche Umlaute
Ä->\195\132  Ö->\195\150  Ü->\195\156
ä->\195\164  ö->\195\182  ü->\195\188  ß->\195\159
]]

-- RPManagerItems.lua
L["greet1"]                 = "|CFFFFCC33[RPManagerItems] aktiviert:"
L["greet2"]                 = "|CFFFFCC33- %s Spezial-Items sind verf\195\188gbar."

-- Items
L["distance"]               = "Distanz"
L["rifle"]                  = "Gewehr"

L["manaflow"]               = "Manafluss"
L["manaflowDesc"]           = "Ein glatter Mithrilstab mit einem Saphir am Kopfende."
L["manaflowComment"]        = "Er knistert vor arkaner Energie."
L["manaflowUsage"]          = "Klick mich."
L["manaflowHelp1"]          = "Alle Gruppenmitglieder werden nach und nach mit Strahlen verbunden. Ziel ist es, so schnell wie möglich, sich kreuzende Linien aufzulösen, indem man sich entsprechend bewegt."
L["manaflowHelp2"]          = "Das Spiel wird hektischer, je mehr Teilnehmer es hat. Sinnvoll ist es ab mindestens 5 Spielern."
L["manaflowWin"]            = "Gewonnen!"
L["manaflowLoose"]          = "Verloren in Level"
L["manaflowTooFew"]         = "Zu wenig Teilnehmer!"
L["manaflowPlayers"]        = "Abbruch wegen Änderung der Spielerzahl."
L["manaflowBtnNew"]         = "Neues Spiel"
L["manaflowBtnStop"]        = "Spiel beenden"
L["manaflowBtnCenter"]      = "Zentrieren"
L["manaflowBtnHelp"]        = "Hilfe"

L["airgun"]                 = "Luftgewehr"
L["airgunDesc"]             = "Ein komplettes Set inklusive Kugeln und Zielscheiben."
L["airgunComment"]          = "Au\195\159er Reichweite von Kindern aufbewahren!"
L["airgunUsage"]            = "Laden und den Abzug betätigen."
L["airgunStart"]            = "Gewehr\\nanlegen"
L["airgunCock"]             = "Hahn\\nspannen"
L["airgunAim"]              = "sorgfältig\\nzielen"
L["airgunWarp"]             = "Verzug\\nbeachten"
L["airgunBreath"]           = "Atmung\\nkontrollieren"
L["airgunDistance"]         = "Entfernung\\neinbeziehen"
L["airgunStand"]            = "Stand\\nfestigen"
L["airgunBlend"]            = "Umgebung\\nausblenden"
L["airgunClose"]            = "Ein Auge\\nschließen"
L["airgunLight"]            = "Lichtverhältnisse\\neinbeziehen"
L["airgunEmoteB"]           = "trifft ins Schwarze."
L["airgunEmote1"]           = "trifft den ersten Ring."
L["airgunEmote2"]           = "trifft den zweiten Ring."
L["airgunEmote3"]           = "trifft den dritten Ring."
L["airgunEmote4"]           = "trifft den äußersten Ring."
L["airgunEmoteF"]           = "schießt daneben."
L["airgunEmoteEmpty"]       = "hat den letzten Schuss abgefeuert."
L["airgunHelp1"]            = "<html><body>"
L["airgunHelp2"]            = "<h2>Schnellstart</h2>"
L["airgunHelp3"]            = "<p>Man beginnt mit Klick auf den Button 'Gewehr anlegen'. Es erscheinen nun 2 neue Buttons mit jeweils einer möglichen Aktion. Zum Beispiel:</p>"
L["airgunHelp4"]            = "<p align=\\\"center\\\">'sorgfältig zielen' vs. 'Lichtverhältnisse einbeziehen'</p>"
L["airgunHelp5"]            = "<p>Man hat nun zwei Sekunden Zeit eine Wahl zu treffen und den Button zu klicken. Dieses Spiel wiederholt sich insgesamt dreimal. Danach wird der Schuss abgefeuert, dessen Qualität anhand der Ergebnisse der Auswahlen ermitteln wird.</p><br/>"
L["airgunHelp6"]            = "<h2>Schussqualität</h2>"
L["airgunHelp7"]            = "<p>Eine Auswahl ist 0-2 Punkte wert. Doch erhält man die möglichen Punkt nur, wenn man von den zwei Alternativen die bessere wählt. Stehen also eine Wahl mit einem Wert von 1 Punkt gegen eine Wahl von 2 Punkten, erhält man entweder 2 Punkte, wenn man die bessere wählt, oder gar keine, wenn man die schlechtere wählt. Man muss also nicht nur schnell wählen, sondern auch heraus finden, welche Aktion die bessere ist.</p><br/>"
L["airgunHelp8"]           = "<h2>Emotes</h2>"
L["airgunHelp9"]           = "<p>Das Spiel wird von einigen Emotes begleitet, das den Umstehenden mitteilt, wie gut man getroffen hat.</p><br/>"
L["airgunHelp10"]           = "<h2>Wertung</h2>"
L["airgunHelp11"]           = "<p>Sobald das Item geschlossen wird, platziert es eine Zielscheibe in der Charakter-Tasche mit den abgegebenen Schüssen und den dafür erhaltenen Punkten:</p>"
L["airgunHelp12"]           = "<p align=\\\"center\\\">Mitte: 10 Punkte</p>"
L["airgunHelp13"]           = "<p align=\\\"center\\\">1. Ring: 5 Punkte</p>"
L["airgunHelp14"]           = "<p align=\\\"center\\\">2. Ring: 4 Punkte</p>"
L["airgunHelp15"]           = "<p align=\\\"center\\\">3. Ring: 3 Punkte</p>"
L["airgunHelp16"]           = "<p align=\\\"center\\\">4. Ring: 2 Punkte</p>"
L["airgunHelp17"]           = "<p>Diese Punkte bitte nicht mit den Punkten aus der Schussqualität verwechseln.</p><br/>"
L["airgunHelp18"]           = "<h1>Entwickelt von Pris @ Aldor-EU</h1>"
L["airgunHelp19"]           = "<h1>Dank an die Tester Fenwing und Evirell (Aldor-EU).</h1>"
L["airgunHelp20"]           = "</body></html>"
L["airgunTargetNameSng"]    = "Zielscheibe (%s Punkte mit einem Schuss)"
L["airgunTargetNamePlu"]    = "Zielscheibe (%s Punkte mit %s Schüssen)"
L["airgunTargetUsage"]      = "Anklicken, um anzusehen."

L["apexis"]                 = "Spielbox 'Der Klang der Apexis'"
L["apexisComment"]          = "Training für die grauen Zellen."
L["apexisUsage"]            = "Lass dich von den Kl\195\164ngen verzaubern."
L["apexisHelp1"]            = "<html><body>"
L["apexisHelp2"]            = "<h2>Anleitung</h2>"
L["apexisHelp3"]            = "<p>Es beginnt mit einem Ton, den die Box vorspielt und den man korrekt nachspielen muss. Der passende Knopf leuchtet dabei kurz auf.</p>"
L["apexisHelp4"]            = "<p>In jeder weiteren Runde wird diese Folge um einen weiteren Ton ergänzt, so dass man immer mehr Töne nachspielen muss.</p>"
L["apexisHelp5"]            = "<p>Dieses geht solange, bis man einen Fehler macht, zu lange braucht oder schlicht aufgibt.</p><br/>"
L["apexisHelp6"]            = "<h1>Entwickelt von Priss (Aldor-EU)</h1>"
L["apexisHelp7"]            = "</body></html>"
L["apexisOutput1"]          = "Ausgabe: im /p oder als Systemnachricht"
L["apexisOutput2"]          = "Ausgabe: im /s"
L["apexisSuccess"]          = "Runde... %s... geschafft."
L["apexisDefeat"]           = "Verloren in Runde... %s... durch... %s."
L["apexisReasonError"]      = "Fehler"
L["apexisReasonGiveUp"]     = "Aufgabe"
L["apexisReasonTime"]       = "Zeitmangel"
