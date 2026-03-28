# Inventaire

## API Client

```lua
-- Ouvrir l'inventaire
DVRCore.Inventory.Open({
    title = 'Sacoche',
    maxSlots = 50,
    columns = 4,
    items = { ... },
    categories = { ... },
})

-- Fermer
DVRCore.Inventory.Close()

-- Verifier si ouvert
DVRCore.Inventory.IsOpen()

-- Mettre a jour les items sans rouvrir
DVRCore.Inventory.UpdateItems(items, weight)
```

## API Server

```lua
-- Ajouter un item a un joueur
local char = player.getActiveChar()
char._inv[tostring(slot)] = { id = 'bread', count = 5 }

-- Items stockes par slot (cles string)
-- Format: { ["1"] = { id = "bread", count = 5 }, ["5"] = { id = "water", count = 2 } }
```

## Systeme Money

```lua
DVRCore.Money.Add(source, 12.50)    -- +$12.50 (12 billets + 50 pieces)
DVRCore.Money.Remove(source, 5.25)  -- -$5.25
DVRCore.Money.Get(source)           -- retourne le total
DVRCore.Money.Set(source, 100.00)   -- set exact
```

## Items

Registre dans `shared/items.lua` :

```lua
DVRCore.RegisterItem('bread', {
    label = 'Pain',
    image = 'bread',
    weight = 0.2,
    category = 'food',
    description = 'Un morceau de pain frais.',
    usable = true,
    droppable = true,
    stackable = true,
    maxStack = 99,
})

DVRCore.GetItem('bread') -- retourne la definition
```

## Categories

```lua
categories = {
    { id = 'all',       label = 'Tout',        icon = './inventory/itemtypes/satchel_nav_all.png' },
    { id = 'food',      label = 'Nourriture',  icon = './inventory/itemtypes/satchel_nav_provisions.png' },
    { id = 'drinks',    label = 'Boissons',    icon = './inventory/itemtypes/satchel_nav_ingredients.png' },
    { id = 'medical',   label = 'Medecine',    icon = './inventory/itemtypes/satchel_nav_remedies.png' },
    { id = 'tools',     label = 'Outils',      icon = './inventory/itemtypes/satchel_nav_kit.png' },
    { id = 'materials', label = 'Materiaux',    icon = './inventory/itemtypes/satchel_nav_materials.png' },
}
```

## Config

```lua
Config.DefaultInventorySlots = 50
Config.Creation.starterItems = {
    { id = 'bread', count = 3 },
    { id = 'water', count = 2 },
}
```
