# Prompts API

API pour les prompts natifs RDR2 (boutons d'action en bas a droite).

## Fonctions

```lua
-- Creer un prompt (group optionnel, holdMode optionnel)
local prompt = DVRCore.Prompt.Create(key, label, group, holdMode)

-- Groupe
local group = DVRCore.Prompt.CreateGroup()

-- Afficher un groupe (appeler chaque frame dans un thread)
DVRCore.Prompt.ShowGroup(group, 'Titre du groupe')

-- Etat
DVRCore.Prompt.SetVisible(prompt, true/false)
DVRCore.Prompt.SetEnabled(prompt, true/false)
DVRCore.Prompt.IsPressed(prompt)          -- true au frame d'appui
DVRCore.Prompt.IsCompleted(prompt)        -- true quand hold fini
DVRCore.Prompt.IsStandardCompleted(prompt)

-- Cleanup
DVRCore.Prompt.Delete(prompt)
```

## Exemple

```lua
local group = DVRCore.Prompt.CreateGroup()
local accept = DVRCore.Prompt.Create(`INPUT_FRONTEND_ACCEPT`, 'Confirmer', group, false)
local toggle = DVRCore.Prompt.Create(`INPUT_CREATOR_MENU_TOGGLE`, 'Changer', group, false)

CreateThread(function()
    while selecting do
        DVRCore.Prompt.ShowGroup(group, 'Selection')
        Wait(0)
    end
end)

-- Cleanup
DVRCore.Prompt.Delete(accept)
DVRCore.Prompt.Delete(toggle)
```
