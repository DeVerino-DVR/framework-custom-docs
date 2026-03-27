# Economie & Taxes par Comte

## Concept

Chaque comte a :
- Un **taux de taxe** (pourcentage)
- Un **maire** (charId d'un joueur)

Quand un script demande un prix, `LcCore.Economy.GetPrice()` applique automatiquement la taxe du comte.

## Comtes par defaut

| ID | Label |
|---|---|
| `new_hanover` | Comte de New Hanover |
| `lemoyne` | Comte de Lemoyne |
| `new_austin` | Comte de New Austin |
| `west_elizabeth` | Comte de West Elizabeth |
| `ambarino` | Comte d'Ambarino |

## API Server

### Calculer un prix avec taxe

```lua
local prixFinal, montantTaxe = LcCore.Economy.GetPrice(10.0, 'new_hanover')
-- Si taxe = 15% -> prixFinal = 11.5, montantTaxe = 1.5
```

### Gestion des comtes

```lua
LcCore.Economy.GetCounties()                    -- tous les comtes (cache)
LcCore.Economy.GetCounty('new_hanover')         -- un comte
LcCore.Economy.SetTax('new_hanover', 15)        -- 15% de taxe
LcCore.Economy.SetMayor('new_hanover', charId)  -- definir le maire
LcCore.Economy.GetMayor('new_hanover')          -- charId du maire
LcCore.Economy.IsMayor(source)                  -- maire de n'importe quel comte?
LcCore.Economy.IsMayor(source, 'new_hanover')   -- maire de ce comte?
```

## Exemple: script boucher

```lua
local LC = exports['LcCore']:GetCore()

-- Le joueur vend de la viande
local basePrix = 10.0
local county = 'new_hanover' -- detecte par zone

local prixFinal, taxe = LcCore.Economy.GetPrice(basePrix, county)
-- Le maire a mis 15% -> prixFinal = 11.5

local player = LC.GetPlayer(source)
player.addMoney(prixFinal)
```

## Callbacks pour le panel NUI (maire)

```lua
-- Client: recuperer tous les comtes
local counties = LcCore.Callback.Await('lc:economy:getCounties')

-- Client: modifier la taxe (verifie si maire ou admin)
local success = LcCore.Callback.Await('lc:economy:setTax', 'new_hanover', 15)
```

## Events

| Event | Params | Description |
|---|---|---|
| `lc:taxChanged` | countyId, taxRate | Taxe modifiee |
| `lc:mayorChanged` | countyId, charId | Maire change |
