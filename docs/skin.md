# Skin API

API pour manipuler l'apparence des personnages (composants, overlays, expressions faciales).

## Modules

| Module | Description |
|---|---|
| `DVRCore.Skin` | Natives wrapper (composants, overlays, refresh) |
| `DVRCore.SkinData` | Donnees de configuration (heritage, features, yeux) |
| `DVRCore.SkinEditor` | Editeur interactif complet |

## DVRCore.Skin

### Composants (MetaPed)

```lua
DVRCore.Skin.ApplyComponent(ped, hash)     -- Applique un shop item
DVRCore.Skin.RemoveComponent(ped, hash)    -- Retire un shop item
DVRCore.Skin.UpdateWearableState(h1, h2)   -- Change l'etat portable
DVRCore.Skin.RemoveTag(ped, tag)           -- Retire un tag MetaPed
DVRCore.Skin.ResetComponents(ped)          -- Reset tout
DVRCore.Skin.EquipPreset(ped, index)       -- Equipe un preset outfit
DVRCore.Skin.RandomOutfit(ped)             -- Outfit aleatoire
```

### Refresh

```lua
DVRCore.Skin.RefreshPed(ped)               -- UpdatePedVariation + RefreshPed
DVRCore.Skin.WaitUntilReady(ped, timeout)  -- Attend que le ped soit rendu
DVRCore.Skin.RefreshShopItems(ped)         -- Refresh MetaPed shop items
```

### Expressions faciales

```lua
DVRCore.Skin.SetExpression(ped, exprId, value)   -- Morphing du visage
DVRCore.Skin.SetFacialIdle(ped, anim, dict)      -- Animation idle du visage
```

### Apparence par defaut

```lua
DVRCore.Skin.SetDefaultAppearance(ped, 'male')   -- Apparence de base
DVRCore.Skin.ApplyFull(ped, skinData)             -- Applique un skin complet
```

### Overlays (textures faciales)

```lua
local txId = DVRCore.Skin.Overlay.CreateTexture(albedoHash)
local layerIdx = DVRCore.Skin.Overlay.Add(txId, overlayId)
DVRCore.Skin.Overlay.SetPalette(txId, layerIdx, paletteHash)
DVRCore.Skin.Overlay.SetColor(txId, layerIdx, primary, secondary, tertiary)
DVRCore.Skin.Overlay.SetVariant(txId, layerIdx, variant)
DVRCore.Skin.Overlay.SetOpacity(txId, layerIdx, opacity)
DVRCore.Skin.Overlay.ApplyToPed(ped, txId, componentHash)
DVRCore.Skin.Overlay.Reset(txId)
DVRCore.Skin.Overlay.Remove(txId)
```

## DVRCore.SkinData

### Heritage

```lua
DVRCore.SkinData.Heritage -- 6 ethnies avec headList, albedo
DVRCore.SkinData.Eyes     -- 14 couleurs d'yeux
```

### Face Features

```lua
DVRCore.SkinData.FaceFeatures.head          -- 6 features (HeadSize, FaceW, FaceD, etc.)
DVRCore.SkinData.FaceFeatures.eyesandbrows  -- 9 features
DVRCore.SkinData.FaceFeatures.ears          -- 4 features
DVRCore.SkinData.FaceFeatures.cheek         -- 3 features
DVRCore.SkinData.FaceFeatures.jaw           -- 3 features
DVRCore.SkinData.FaceFeatures.chin          -- 3 features
DVRCore.SkinData.FaceFeatures.nose          -- 6 features
DVRCore.SkinData.FaceFeatures.mouthandlips  -- 18 features
DVRCore.SkinData.FaceFeatures.upperbody     -- 7 features
DVRCore.SkinData.FaceFeatures.lowerbody     -- 2 features
```

Chaque feature : `{ label = 'Largeur nez', hash = 0x6E7F, comp = 'NoseW' }`

### Composants

```lua
DVRCore.SkinData.ComponentCategories  -- Hashes joaat de toutes les categories (Hair, Beard, Boots, etc.)
DVRCore.SkinData.TextureTypes         -- Albedo/normal/material par genre
DVRCore.SkinData.OverlayCounts        -- Nombre d'overlays par categorie
DVRCore.SkinData.DefaultSkin          -- Structure par defaut du skin (tous les champs)
DVRCore.SkinData.DefaultClothing      -- Structure par defaut des vetements
```

## DVRCore.SkinEditor

### Ouvrir l'editeur

```lua
DVRCore.SkinEditor.Open('male', existingSkin or {}, function(skinData)
    -- skinData contient toutes les valeurs du skin
    print(json.encode(skinData))
end)
```

### Categories de l'editeur

| Categorie | Type de controle | Update |
|---|---|---|
| Heritage | Selection + preview live | Navigation |
| Visage | Grille 2D par paires | Drag |
| Yeux | Selection + preview live | Navigation |
| Cheveux | Selection + preview live | Navigation |
| Corps | Sliders (fleches G/D) | Immediat |
| Taille | Slider (fleches G/D) | Immediat |
