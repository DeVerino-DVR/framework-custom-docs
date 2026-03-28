# Evenements

## Server Events

Tous les events emettent le **charId** (identifiant permanent), jamais la source.

Ecouter avec `AddEventHandler()`.

| Event | Params | Declencheur |
|---|---|---|
| `dvr:jobChanged` | charId, newJob, oldJob | `player.setJob()` |
| `dvr:gangChanged` | charId, gang | `player.setGang()` |
| `dvr:groupChanged` | charId, group | `player.setGroup()` |
| `dvr:moneyChanged` | charId, type, amount, action | `player.addMoney/removeMoney/addGold/removeGold` |
| `dvr:itemChanged` | charId, item, count, action | `player.addItem/removeItem` |
| `dvr:taxChanged` | countyId, taxRate | `DVRCore.Economy.SetTax()` |
| `dvr:mayorChanged` | countyId, charId | `DVRCore.Economy.SetMayor()` |

### Exemples

```lua
-- Reagir a un changement de job
AddEventHandler('dvr:jobChanged', function(charId, newJob, oldJob)
    print('CharId', charId, 'passe de', oldJob.name, 'a', newJob.name)
end)

-- Logger les transactions
AddEventHandler('dvr:moneyChanged', function(charId, type, amount, action)
    print('CharId', charId, action, amount, type)
end)

-- Reagir a un changement de taxe
AddEventHandler('dvr:taxChanged', function(countyId, taxRate)
    print('Taxe de', countyId, 'changee a', taxRate .. '%')
end)
```

## Client Events

| Event | Params | Description |
|---|---|---|
| `dvr:playerSpawned` | charId, firstname, lastname | Joueur spawn apres selection |
| `dvr:spawn` | data (table) | Trigger le spawn client |
| `dvr:selectCharacter` | charList (table) | Ouvre la selection de personnage |
| `dvr:createCharacter` | - | Ouvre la creation de personnage |
| `dvr:notify` | type, ... | Notification native |

### Exemple

```lua
AddEventHandler('dvr:playerSpawned', function(charId, firstname, lastname)
    print('Spawn en tant que', firstname, lastname, '(charId:', charId, ')')
end)
```

## Flow de connexion

```
Joueur se connecte
    -> playerConnecting (verif Discord + ban)
    -> dvr:playerJoined (charge les personnages)
    -> 0 perso: dvr:createCharacter
    -> 1 perso: dvr:spawn (direct)
    -> 2+ persos: dvr:selectCharacter -> dvr:charSelected -> dvr:spawn
    -> dvr:playerSpawned

Resource restart
    -> save tous les joueurs
    -> re-trigger dvr:playerJoined
    -> meme flow (pas besoin de reco)

Joueur drop
    -> playerDropped (save + cleanup index)
```

## Identifiants

| Identifiant | Usage | Scope |
|---|---|---|
| **charId** | ID permanent du joueur, utilise partout | Public (API, events, commandes) |
| **discord** | Discord ID, pour les bans et l'auth | Interne (auth, bans) |
| **source** | ID temporaire de session FiveM/RedM | Interne uniquement (transport reseau) |

Un script externe ne devrait **jamais** manipuler la source directement. Toujours passer par le charId :

```lua
local LC = exports['DVRCore']:GetCore()

-- Trouver un joueur par son charId
local player = LC.GetPlayerByCharId(42)
player.addMoney(100)
player.addItem('bread', 5)

-- Admin: ban par charId
LC.Admin.Ban(42, 'Triche', 86400)

-- Commandes: le callback recoit deja le charId
LC.Commands.Register('heal', 'admin', function(charId, args)
    local targetId = tonumber(args[1])
    -- targetId = charId du joueur cible
end)
```
