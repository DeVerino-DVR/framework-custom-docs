# Character - Creation de personnage

## Flow

1. Le joueur se connecte, le serveur detecte 0 personnages → `dvr:createCharacter`
2. Intro cinematique (AnimScene RDO avec Sheriff + Deputy)
3. Selection du genre (Tab + Enter avec prompts natifs)
4. Le ped marche vers le miroir, camera suit
5. Formulaire (prenom, nom, date de naissance, nationalite, taille)
6. Editeur de skin (heritage, visage, yeux, cheveux, corps, taille)
7. Spawn aleatoire

## Fichiers

| Fichier | Role |
|---------|------|
| `client/spawn.lua` | Flow complet (animscene, genre, formulaire, spawn) |
| `client/modules/skin/editor.lua` | Editeur de skin avec `Menu.Push` |
| `client/modules/skin/data.lua` | Donnees skin (heritage, face features, yeux, composants) |
| `client/modules/skin/skin.lua` | API natives skin (composants, overlays, expressions) |
| `config/config.lua` | `Config.Creation.genderViews` |

## Config

```lua
Config.Creation = {
    genderViews = {
        { pos = vector3(...), rot = vector3(...), fov = 35.0, focus = 4.0 }, -- Male
        { pos = vector3(...), rot = vector3(...), fov = 35.0, focus = 4.0 }, -- Female
    },
}
```

## Events

| Event | Direction | Description |
|-------|-----------|-------------|
| `dvr:createCharacter` | Server → Client | Declenche la creation (0 personnages) |
| `dvr:createChar` | Client → Server | Envoie les donnees du nouveau personnage |
| `dvr:spawn` | Server → Client | Spawn le joueur aux coordonnees |
| `dvr:playerSpawned` | Client event | Declenche apres le spawn |

## Editeur de skin

L'editeur utilise `DVRCore.SkinEditor.Open(gender, skin, onDone)`.

### Categories

- **Heritage** : couleur de peau (6 ethnies), choix de tete (20 modeles par ethnie)
- **Visage** : 8 zones (tete, yeux, oreilles, pommettes, machoire, menton, nez, bouche) avec grille 2D
- **Yeux** : 14 couleurs, preview live en navigant
- **Cheveux** : liste dynamique, preview live en navigant
- **Corps** : 9 sliders (bras, epaules, dos, poitrine, taille, hanches, cuisses, mollets), update live
- **Taille** : echelle du ped (0.90 a 1.10)

### Grille 2D

Les traits du visage sont edites par paires avec une grille 2D draggable :
- `axis: 'xy'` → carre (2 axes)
- `axis: 'x'` → rectangle horizontal (1 axe)
- Le point rouge se deplace en temps reel
- Les modifications sont appliquees instantanement via `SetCharExpression`
