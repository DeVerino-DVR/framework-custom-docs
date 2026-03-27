# LcCore Framework

Framework custom pour LastCountry (RedM).

## Principes

- **Discord ID** comme identifiant unique
- **Style ESX** : `player.addMoney()`, `player.addItem()`, `player.setJob()`
- **State Bags** : sync temps reel server -> client
- **KVP** : preferences locales sans reseau
- **ox_lib style callbacks** : `LcCore.Callback.Await()` avec return direct
- **Notifications natives** RedM (pas de NUI pour les notifs)
- **Optimise 800+ joueurs** : zero boucle, tout en cache table
- **Multi-personnage** : 1 perso = spawn direct, 2+ = selection

## Structure

```
LcCore/
├── fxmanifest.lua
├── config/config.lua
├── shared/shared.lua
├── sql/database.sql
├── client/
│   ├── dataview.lua          -- Buffer binaire pour natives RDR3
│   ├── callbacks.lua         -- Callback system (ox_lib style)
│   ├── spawn.lua             -- Spawn & selection personnage
│   ├── api.lua               -- Exports client
│   ├── main.lua              -- Entry point
│   └── modules/
│       ├── notifications.lua -- Notifications natives RDR3
│       ├── hud.lua           -- HUD
│       ├── state.lua         -- State Bags (lecture)
│       ├── kvp.lua           -- KVP (stockage local)
│       └── utils.lua         -- Utilitaires
├── server/
│   ├── callbacks.lua         -- Callback system
│   ├── commands.lua          -- Commandes
│   ├── api.lua               -- Exports server
│   ├── main.lua              -- Entry point & connexion
│   ├── classes/
│   │   ├── player.lua        -- Player ESX-style + State Bags
│   │   └── character.lua     -- Character data
│   └── modules/
│       ├── economy.lua       -- Taxes par comte
│       ├── inventory.lua     -- Inventaire
│       ├── admin.lua         -- Admin
│       ├── jobs.lua          -- Jobs
│       └── saves.lua         -- Auto-save
├── ui/                       -- NUI (React)
└── docs/                     -- Documentation
```

## Pages

- [API Server](./server.md) - Player, economy, callbacks
- [API Client](./client.md) - State Bags, KVP, notifications
- [Economie & Taxes](./economy.md) - Systeme de comtes
- [Base de donnees](./database.md) - Schema SQL
- [Evenements](./events.md) - Liste des events
