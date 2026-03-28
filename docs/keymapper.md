# KeyMapper

Gestionnaire de raccourcis clavier integre avec persistance KVP.

## API

```lua
-- Enregistrer une touche
DVRCore.KeyMapper.Register('inventory', 'Ouvrir l\'inventaire', 'B')

-- Attacher un callback
DVRCore.KeyMapper.On('inventory', 'down', function()
    -- action
end)

-- Changer la touche (persiste en KVP)
DVRCore.KeyMapper.SetKey('inventory', 'N')

-- Recuperer la touche actuelle
local code = DVRCore.KeyMapper.GetKey('inventory')

-- Nom lisible
local name = DVRCore.KeyMapper.GetKeyName(code) -- "B"

-- Tous les bindings
local all = DVRCore.KeyMapper.GetAll()

-- Pret ?
DVRCore.KeyMapper.IsReady()
```

## Menu de remapping

Commande `/touches` pour ouvrir le menu de remapping des touches.

## Touches par defaut

| ID | Description | Touche |
|---|---|---|
| `inventory` | Ouvrir l'inventaire | B |
| `inv_drop` | Tout jeter | F |
| `inv_discard` | Jeter | Space |
| `inv_use` | Utiliser | Enter |
| `inv_give` | Donner | G |
| `inv_close` | Fermer inventaire | Escape |

## Persistance

Les touches sont sauvegardees en KVP (cote client). Chaque joueur peut personnaliser ses touches via `/touches`.
