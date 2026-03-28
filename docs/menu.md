# Menu API

API pour ouvrir des menus RDR2 depuis le Lua. Systeme de stack pour les sous-menus (zero flash).

## Fonctions

### Menu.Open(options, onSelect, onClose)

Ouvre un menu (reset le stack, monte le composant NUI).

```lua
DVRCore.Menu.Open({
    title = 'Mon Menu',
    subtitle = 'Options',
    items = { ... },
    position = 'top-left',
    maxVisibleItems = 11,
    canClose = true,
}, function(index, scrollIndex, data)
    -- data.texts, data.indexes, data.checked, data.sliders
end, function()
    print('Menu ferme')
end)
```

### Menu.Push(options, onSelect, onClose)

Ouvre un sous-menu sans flash. Le menu actuel est sauvegarde dans le stack. Le NUI est mis a jour sans remonter le composant React.

```lua
DVRCore.Menu.Push({
    title = 'Sous-menu',
    subtitle = 'Detail',
    items = { ... },
    canClose = false,
    onBack = function() -- Backspace
        showParentMenu()
    end,
}, function(index) end)
```

### Menu.Back()

Pop le stack et restaure les callbacks du menu parent. Retourne `true` si un pop a ete fait.

### Menu.Close()

Ferme tout (reset stack, cache NUI, relache le focus).

### Menu.GetStackSize()

Retourne le nombre de niveaux dans le stack.

## Options du menu

| Propriete | Type | Description |
|---|---|---|
| `title` | string | Titre du menu |
| `subtitle` | string? | Sous-titre |
| `items` | table | Liste des items |
| `position` | string? | `'top-left'`, `'top-right'`, `'bottom-left'`, `'bottom-right'` |
| `maxVisibleItems` | number? | Max items visibles (defaut 11, max 20) |
| `canClose` | boolean? | `false` = Escape ne ferme pas, Backspace = retour |
| `instant` | boolean? | `true` = pas d'animation d'ouverture |

## Callbacks dans options

| Callback | Params | Description |
|---|---|---|
| `onBack(index)` | index courant | Backspace quand `canClose = false` |
| `onPreview(index, scrollIndex, item)` | navigation | Change d'item selectionne |
| `onIndexChange(index, scrollIndex)` | fleches G/D | Scroll value change (live) |
| `onGridChange(index, x, y)` | grille 2D | Point deplace (-1.0 a 1.0) |
| `onSliderChange(index, sliderIndex, value)` | slider | Valeur slider change |
| `onCheckChange(index, checked)` | checkbox | Toggle checkbox |
| `onChild(index, child, item)` | sous-menu | Item avec `child` selectionne |

## Options d'un item

| Propriete | Type | Description |
|---|---|---|
| `label` | string | Texte principal |
| `rightLabel` | string? | Texte a droite |
| `description` | string? | Description en bas du menu |
| `values` | string[]? | Valeurs scrollables (fleches G/D) |
| `defaultIndex` | number? | Index de depart (1-based) |
| `checked` | boolean? | Checkbox |
| `type` | string? | `'separator'`, `'text'` |
| `disabled` | boolean? | Grise l'item |
| `close` | boolean? | `false` = ne ferme pas apres Enter |
| `grid` | boolean/table? | Grille 2D dans la description |
| `icon` | string? | Icone a gauche |
| `price` | number? | Prix affiche |
| `child` | string? | ID de sous-menu |
| `sliders` | table[]? | Sliders (bar ou switch) |
| `statistics` | table[]? | Barres de stats |
| `subtitle` | string? | Sous-titre sous le label |
| `footer` | string? | Texte en bas du footer |

## Grille 2D

Nouveau type d'item pour ajuster des valeurs en 2 dimensions.

```lua
{ label = 'Largeur / Hauteur', grid = { labelX = 'Largeur', labelY = 'Hauteur', axis = 'xy' } }
{ label = 'Juste largeur',     grid = { labelX = 'Largeur', axis = 'x' } }
{ label = 'Grid simple',       grid = true }
```

| `axis` | Forme | Description |
|---|---|---|
| `'xy'` | Carre | 2 axes (defaut) |
| `'x'` | Rectangle horizontal | 1 axe gauche/droite |
| `'y'` | Rectangle vertical | 1 axe haut/bas |

Le callback `onGridChange(index, x, y)` envoie les valeurs de -1.0 a 1.0.

## Exemple : menu avec sous-menus (stack)

```lua
local function showDetails(item, backFn)
    DVRCore.Menu.Push({
        title = item.name,
        subtitle = 'Detail',
        items = {
            { label = 'Prix', rightLabel = '$' .. item.price },
            { label = 'Quantite', values = {'1','2','3','4','5'}, defaultIndex = 1, close = false },
        },
        canClose = false,
        onBack = function() backFn() end,
        onIndexChange = function(index, scrollIndex)
            print('Quantite:', scrollIndex + 1)
        end,
    }, function(index)
        if index == 1 then print('Achete!') end
        backFn()
    end)
end

local function showShop()
    DVRCore.Menu.Open({
        title = 'Epicerie',
        subtitle = 'Valentine',
        items = {
            { label = 'Pain',    rightLabel = '$2.50', close = false },
            { label = 'Viande',  rightLabel = '$8.00', close = false },
            { label = 'Whiskey', rightLabel = '$5.00', close = false },
        },
    }, function(index)
        showDetails(items[index + 1], showShop)
    end)
end
```
