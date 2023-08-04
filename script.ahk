#MaxHotkeysPerInterval 300
;#ifWinActive, TERA
SetKeyDelay 3
config := "state.txt"
FileRead, state, %config%

ahkactive := true

; Définir l'array des touches à répéter
touches := ["&", "é", "SC004", "'", "Tab", "w", "x", "c", "v", "a", "e", "r", "ç", "à"]

; Boucle principale du script
loop
{
    ; Parcourir toutes les touches de l'array
    for each, touche in touches
    {
        ; Vérifier si la touche est pressée
        if (GetKeyState(touche, "P"))  ; Vérifie si la touche est enfoncée (P pour "pressed")
        {
			FileRead, state, %config%
            ; Exécuter l'action souhaitée pour la touche ici
            ; Par exemple, pour simuler la frappe de la touche, vous pouvez utiliser Send:
			if (state = 1 && ahkactive) {
				SendInput {%touche%}
			}         
            
            ; Ajouter une petite pause pour éviter de surcharger le système
            Sleep 5
        }
    }

	if (state = 3) {
		ExitApp
	}
    
    ; Laisser un petit délai pour ne pas surcharger le système
    Sleep 10
}


End::
	Suspend
	if (!ahkactive)
	{
		TrayTip %A_ScriptName%, Script has been deactivated.
	}
	else
	{
		TrayTip %A_ScriptName%, Script has been activated.
	}
	ahkactive := !ahkactive
	Return

$~F12::
	Reload
	Return
