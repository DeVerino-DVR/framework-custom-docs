# API Server

## Recuperer le Core

```lua
local LC = exports['LcCore']:GetCore()
```

## Player (style ESX)

Toutes les methodes sont directement sur l'objet player. Chaque setter met a jour automatiquement le State Bag correspondant.

```lua
local player = LC.GetPlayer(source)
```

### Identite

| Methode | Retour | Description |
|---|---|---|
| `player.getSource()` | number | Source du joueur |
| `player.getDiscord()` | string | Discord ID |
| `player.getName()` | string | "Prenom Nom" |
| `player.getFirstname()` | string | Prenom |
| `player.getLastname()` | string | Nom |
| `player.getCharId()` | number | ID du personnage actif |

### Groupe

| Methode | Retour | Description |
|---|---|---|
| `player.getGroup()` | string | 'user' / 'admin' / 'superadmin' |
| `player.setGroup(group)` | - | Change le groupe (+ State Bag) |

### Job

Le job est stocke en JSON : `{ name, grade, label }`

| Methode | Retour | Description |
|---|---|---|
| `player.getJob()` | table | `{ name, grade, label }` |
| `player.setJob(name, grade, label?)` | - | Change le job (+ State Bag + event) |

### Gang

| Methode | Retour | Description |
|---|---|---|
| `player.getGang()` | string | Gang actuel |
| `player.setGang(gang)` | - | Change le gang |

### Argent

| Methode | Retour | Description |
|---|---|---|
| `player.getMoney()` | number | Argent |
| `player.addMoney(amount)` | - | Ajoute de l'argent |
| `player.removeMoney(amount)` | boolean | Retire (false si pas assez) |
| `player.getGold()` | number | Or |
| `player.addGold(amount)` | - | Ajoute de l'or |
| `player.removeGold(amount)` | boolean | Retire (false si pas assez) |

### Inventaire

| Methode | Retour | Description |
|---|---|---|
| `player.getInventory()` | table | `{ {name, count}, ... }` |
| `player.addItem(item, count)` | - | Ajoute un item |
| `player.removeItem(item, count)` | boolean | Retire (false si pas assez) |
| `player.getItemCount(item)` | number | Quantite d'un item |
| `player.getSlots()` | number | Nombre de slots |
| `player.addSlots(amount)` | - | Ajoute des slots |

### Coords & Status

| Methode | Retour | Description |
|---|---|---|
| `player.getCoords()` | vector3 | Position |
| `player.setCoords(coords)` | - | Change la position |
| `player.isDead()` | boolean | Est mort |
| `player.setDead(state)` | - | Change l'etat mort |
| `player.getXP()` | number | Experience |
| `player.addXP(amount)` | - | Ajoute de l'XP |

### Skin

| Methode | Retour | Description |
|---|---|---|
| `player.getSkin()` | table | Donnees skin |
| `player.setSkin(skin)` | - | Change le skin |

### Multi-personnage

| Methode | Retour | Description |
|---|---|---|
| `player.getCharacters()` | table | Tous les personnages |
| `player.getCharCount()` | number | Nombre de personnages |
| `player.setActiveChar(charId)` | boolean | Selectionne un personnage |
| `player.getActiveChar()` | table? | Personnage actif |

## Recherche de joueurs

```lua
LC.GetPlayer(source)          -- par source (O(1))
LC.GetPlayers()               -- tous {[source] = player}
LC.GetPlayerByDiscord('1234') -- par discord id
LC.GetPlayerByCharId(5)       -- par character id
```

## Sauvegarde

```lua
LC.SavePlayer(source) -- sauvegarde un joueur
LC.SaveAll()          -- sauvegarde tout le monde
```

Auto-save toutes les 5 minutes (configurable).

## Callbacks (ox_lib style)

### Register

```lua
LcCore.Callback.Register('lc:getPlayerData', function(source)
    local player = LcCore.GetPlayer(source)
    return {
        name  = player.getName(),
        money = player.getMoney(),
        job   = player.getJob(),
    }
end)
```

Le client appelle avec `LcCore.Callback.Await()` et recoit le return directement.
