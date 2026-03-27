# Evenements

## Server Events

Ecouter avec `AddEventHandler()`.

| Event | Params | Declencheur |
|---|---|---|
| `lc:jobChanged` | source, newJob, oldJob | `player.setJob()` |
| `lc:gangChanged` | source, gang | `player.setGang()` |
| `lc:groupChanged` | source, group | `player.setGroup()` |
| `lc:moneyChanged` | source, type, amount, action | `player.addMoney/removeMoney/addGold/removeGold` |
| `lc:itemChanged` | source, item, count, action | `player.addItem/removeItem` |
| `lc:taxChanged` | countyId, taxRate | `LcCore.Economy.SetTax()` |
| `lc:mayorChanged` | countyId, charId | `LcCore.Economy.SetMayor()` |

### Exemples

```lua
-- Reagir a un changement de job
AddEventHandler('lc:jobChanged', function(source, newJob, oldJob)
    print(source, 'est passe de', oldJob.name, 'a', newJob.name)
end)

-- Logger les transactions
AddEventHandler('lc:moneyChanged', function(source, type, amount, action)
    print(source, action, amount, type)
end)

-- Reagir a un changement de taxe
AddEventHandler('lc:taxChanged', function(countyId, taxRate)
    print('Taxe de', countyId, 'changee a', taxRate .. '%')
end)
```

## Client Events

| Event | Params | Description |
|---|---|---|
| `lc:playerSpawned` | charId, firstname, lastname | Joueur spawn apres selection |
| `lc:spawn` | data (table) | Trigger le spawn client |
| `lc:selectCharacter` | charList (table) | Ouvre la selection de personnage |
| `lc:createCharacter` | - | Ouvre la creation de personnage |
| `lc:notify` | type, ... | Notification native |

### Exemple

```lua
-- Faire quelque chose quand le joueur spawn
AddEventHandler('lc:playerSpawned', function(charId, firstname, lastname)
    print('Spawn en tant que', firstname, lastname, '(charId:', charId, ')')
end)
```

## Flow de connexion

```
Joueur se connecte
    -> playerConnecting (verif Discord + ban)
    -> lc:playerJoined (charge les personnages)
    -> 0 perso: lc:createCharacter
    -> 1 perso: lc:spawn (direct)
    -> 2+ persos: lc:selectCharacter -> lc:charSelected -> lc:spawn
    -> lc:playerSpawned

Resource restart
    -> save tous les joueurs
    -> re-trigger lc:playerJoined
    -> meme flow (pas besoin de reco)

Joueur drop
    -> playerDropped (save + cleanup cache)
```
