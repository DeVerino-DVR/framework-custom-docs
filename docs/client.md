# API Client

## Recuperer le Core

```lua
local LC = exports['DVRCore']:GetCore()
```

## Callbacks

Toujours en `Await` avec return direct, jamais de `cb()`.

```lua
-- Appel synchrone
local data = DVRCore.Callback.Await('dvr:getPlayerData')
print(data.name, data.money)

-- Avec arguments
local price, tax = DVRCore.Callback.Await('dvr:getPrice', 10.0, 'new_hanover')
```

## State Bags

Les State Bags sont mis a jour automatiquement par le server a chaque setter (`player.addMoney()`, `player.setJob()`, etc.). Cote client, les valeurs sont lisibles **instantanement** sans callback ni event.

### Lire une valeur

```lua
local money = LC.State.Get('money')
local job   = LC.State.Get('job')     -- { name, grade, label }
local gold  = LC.State.Get('gold')
local xp    = LC.State.Get('xp')
local dead  = LC.State.Get('isDead')
local inv   = LC.State.Get('inventory')
```

### Ecouter les changements

```lua
LC.State.OnChange('money', function(value)
    print('Argent:', value)
end)

LC.State.OnChange('job', function(job)
    print('Job:', job.name)
end)
```

### States disponibles

| Key | Type | Description |
|---|---|---|
| `charId` | number | ID du personnage actif |
| `name` | string | Prenom + Nom |
| `group` | string | user/admin/superadmin |
| `job` | table | { name, grade, label } |
| `gang` | string | Gang |
| `money` | number | Argent |
| `gold` | number | Or |
| `inventory` | table | Inventaire complet |
| `slots` | number | Nombre de slots |
| `isDead` | boolean | Est mort |
| `xp` | number | Experience |

## KVP (stockage local)

Pour les preferences du joueur. Stocke localement sur la machine, pas de reseau, pas de DB.

```lua
-- Sauvegarder
LC.KVP.Set('hud_visible', true)
LC.KVP.Set('volume', 0.8)

-- Lire
local visible = LC.KVP.GetBool('hud_visible', true)   -- default = true
local volume  = LC.KVP.GetFloat('volume', 1.0)
local county  = LC.KVP.GetString('last_county', '')
local prefs   = LC.KVP.GetJSON('user_prefs', {})
local count   = LC.KVP.GetInt('counter', 0)

-- Supprimer
LC.KVP.Delete('old_key')
```

## Notifications (natives RDR3)

Notifications natives de Red Dead, pas de NUI.

### Depuis le client

```lua
DVRCore.Notify.Tip('Message simple', 3000)
DVRCore.Notify.Right('Tip a droite', 3000)
DVRCore.Notify.Center('Centre ecran', 3000, 'COLOR_PURE_WHITE')
DVRCore.Notify.Bottom('Objectif', 3000)
DVRCore.Notify.BottomRight('Bas droite', 3000)
DVRCore.Notify.Top('Message', 'Valentine', 3000)
DVRCore.Notify.SimpleTop('Titre', 'Sous-titre', 3000)
DVRCore.Notify.Left('Titre', 'Sous-titre', 'generic_textures', 'tick', 3000, 'COLOR_WHITE')
DVRCore.Notify.Advanced('Texte', 'generic_textures', 'tick', 'COLOR_WHITE', 3000)
DVRCore.Notify.LeftRank('Titre', 'Sous-titre', 'generic_textures', 'tick', 5000, 'COLOR_WHITE')
DVRCore.Notify.Fail('Titre', 'Sous-titre', 3000)
DVRCore.Notify.Dead('Titre', 'audioRef', 'audioName', 3000)
DVRCore.Notify.Update('Titre', 'Message', 3000)
DVRCore.Notify.Warning('Titre', 'Message', 'audioRef', 'audioName', 3000)
```

### Depuis le server

```lua
-- Envoie un type de notification a un joueur
TriggerClientEvent('dvr:notify', source, 'Tip', 'Message ici', 3000)
TriggerClientEvent('dvr:notify', source, 'Center', 'Bienvenue!', 5000)
TriggerClientEvent('dvr:notify', source, 'Left', 'Titre', 'Sous-titre', 'generic_textures', 'tick', 3000)
```

### Types de notifications

| Methode | Position | Icone | Description |
|---|---|---|---|
| `Tip` | Haut droite | Non | Message simple |
| `Right` | Droite | Non | Tip droite |
| `Left` | Gauche | Oui | Avec icone (dict + texture) |
| `Top` | Haut centre | Non | Avec nom de lieu |
| `Center` | Centre | Non | Texte centre ecran |
| `Bottom` | Bas droite | Non | Style objectif |
| `BottomRight` | Bas droite | Non | Notification bas droite |
| `SimpleTop` | Haut | Non | Titre + sous-titre |
| `Advanced` | Droite | Oui | Avec icone et couleur |
| `LeftRank` | Gauche | Oui | Style rank up |
| `Fail` | Centre | Non | Mission echouee |
| `Dead` | Centre | Non | Mort du joueur |
| `Update` | Centre | Non | Mise a jour mission |
| `Warning` | Centre | Non | Avertissement |
