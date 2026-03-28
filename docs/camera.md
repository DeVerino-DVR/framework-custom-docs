# Camera API

API pour gerer les cameras scriptees RDR2.

## Fonctions

```lua
local cam = DVRCore.Camera.Create(pos, rot, fov)     -- Cree une camera
DVRCore.Camera.Destroy(cam)                           -- Detruit une camera
DVRCore.Camera.SetActive(cam, render)                 -- Active + RenderScriptCams
DVRCore.Camera.StopRendering()                        -- Arrete le rendu script
DVRCore.Camera.Interp(from, to, duration, easeIn, easeOut)  -- Interpolation
DVRCore.Camera.InterpWait(from, to, duration)         -- Interpolation + Wait
DVRCore.Camera.SetFocus(cam, dist)                    -- Distance de focus
DVRCore.Camera.SetMotionBlur(cam, strength)           -- Motion blur
DVRCore.Camera.Shake(cam, shakeType, amplitude)       -- Tremblement
DVRCore.Camera.PlayPostFX(name)                       -- Effet post-process
DVRCore.Camera.StopPostFX(name)                       -- Arrete un effet
```

## Exemple

```lua
local cam = DVRCore.Camera.Create(
    vector3(-562.15, -3776.22, 239.11),
    vector3(-4.71, 0.0, -93.14),
    45.0
)
DVRCore.Camera.SetActive(cam)
DVRCore.Camera.SetFocus(cam, 4.0)
DVRCore.Camera.Shake(cam, 'HAND_SHAKE', 0.04)

-- Plus tard
DVRCore.Camera.Destroy(cam)
DVRCore.Camera.StopRendering()
```
