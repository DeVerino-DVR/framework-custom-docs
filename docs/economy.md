# Economie & Taxes par Comte

## Concept

Chaque comte a :
- Un **taux de taxe** (pourcentage)
- Un **maire** (charId d'un joueur)

Quand un script demande un prix, `DVRCore.Economy.GetPrice()` applique automatiquement la taxe du comte.

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
local prixFinal, montantTaxe = DVRCore.Economy.GetPrice(10.0, 'new_hanover')
-- Si taxe = 15% -> prixFinal = 11.5, montantTaxe = 1.5
```

### Gestion des comtes

```lua
DVRCore.Economy.GetCounties()                    -- tous les comtes (cache)
DVRCore.Economy.GetCounty('new_hanover')         -- un comte
DVRCore.Economy.SetTax('new_hanover', 15)        -- 15% de taxe
DVRCore.Economy.SetMayor('new_hanover', charId)  -- definir le maire
DVRCore.Economy.GetMayor('new_hanover')          -- charId du maire
DVRCore.Economy.IsMayor(source)                  -- maire de n'importe quel comte?
DVRCore.Economy.IsMayor(source, 'new_hanover')   -- maire de ce comte?
```

## Exemple: script boucher

```lua
local LC = exports['DVRCore']:GetCore()

-- Le joueur vend de la viande
local basePrix = 10.0
local county = 'new_hanover' -- detecte par zone

local prixFinal, taxe = DVRCore.Economy.GetPrice(basePrix, county)
-- Le maire a mis 15% -> prixFinal = 11.5

local player = LC.GetPlayer(source)
player.addMoney(prixFinal)
```

## Callbacks pour le panel NUI (maire)

```lua
-- Client: recuperer tous les comtes
local counties = DVRCore.Callback.Await('dvr:economy:getCounties')

-- Client: modifier la taxe (verifie si maire ou admin)
local success = DVRCore.Callback.Await('dvr:economy:setTax', 'new_hanover', 15)
```

## Events

| Event | Params | Description |
|---|---|---|
| `dvr:taxChanged` | countyId, taxRate | Taxe modifiee |
| `dvr:mayorChanged` | countyId, charId | Maire change |
