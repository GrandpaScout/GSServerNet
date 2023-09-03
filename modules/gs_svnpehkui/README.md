# SNPehkui
This module allows Figura Avatars to request a Pehkui scale from the server.


## Client
To use this as the client, send an SVNet message containing the scale you want to edit and the size (in %, 100 = 100%)
you want to use for that scale.
```lua
-- Sets the physics scale of the avatar to 150%
SVNet.send("peh_phys", 150)
```

If the size you requested is not in range, you will get the closest size that is in range.  
(Ex. Max size on the server is 250%, you request 300%, you get 250%)

If the size you requested is not in the interval, it will be rounded down to the previous interval.  
(Ex. Interval is 5%, you request 63%, you get 60%)

> [!NOTE]  
> **Scales do *not* multiply with each other.**  
> If you request a broad scale like `peh_phys` and then request a scale like `peh_bbox`, then everything except for the
> hitbox scale will follow `peh_phys` while the hitbox scale will follow `peh_bbox`.

A list of messages and the scales they modify are given below:
* **`peh_all`**  
  > `pehkui:model_width`, `pehkui:model_height`, `pehkui:hitbox_width`, `pehkui:hitbox_height`, `pehkui:eye_height`,
  > `pehkui:motion`, `pehkui:reach`, `pehkui:projectiles`, `pehkui:drops`
* **`peh_all_w`**  
  > `pehkui:model_width`, `pehkui:hitbox_width`
* **`peh_all_h`**  
  > `pehkui:model_height`, `pehkui:hitbox_height`, `pehkui:eye_height`, `pehkui:motion`, `pehkui:reach`
* **`peh_mdl`**  
  > `pehkui:model_width`, `pehkui:model_height`
* **`peh_mdl_w`**  
  > `pehkui:model_width`
* **`peh_mdl_h`**  
  > `pehkui:model_height`
* **`peh_phys`**  
  > `pehkui:hitbox_width`, `pehkui:hitbox_height`, `pehkui:eye_height`, `pehkui:motion`, `pehkui:reach`,
  > `pehkui:projectiles`, `pehkui:drops`
* **`peh_phys_w`**  
  > `pehkui:hitbox_width`
* **`peh_phys_h`**  
  > `pehkui:hitbox_height`, `pehkui:eye_height`, `pehkui:motion`, `pehkui:reach`
* **`peh_bbox`**  
  > `pehkui:hitbox_width`, `pehkui:hitbox_height`
* **`peh_bbox_w`**  
  > `pehkui:hitbox_width`
* **`peh_bbox_h`**  
  > `pehkui:hitbox_height`
* **`peh_eye_h`**  
  > `pehkui:eye_height`
* **`peh_motion`**  
  > `pehkui:motion`
* **`peh_reach`**  
  > `pehkui:reach`
* **`peh_proj`**  
  > `pehkui:projectiles`
* **`peh_drops`**  
  > `pehkui:drops`


## Server
Simply install the datapack next to the `GSServerNet` datapack.

There are soft limits and hard limits for scales in this datapack. They can be changed by the server owner if
needed.  
&nbsp;
### To change the soft limits:
Use the following commands in-game to set the minimum and maximum scales that players can use:
```mcfunction
# To set the minimum scale limit in % (100 = 100%)
scoreboard players set #min svnpeh.limits ###

# To set the maximum scale limit in % (100 = 100%)
scoreboard players set #max svnpeh.limits ###
```
These values will never be changed by the datapack unless they are out of range on (re).
&nbsp;
### To change the hard limits:
Go to the `svn_pehkui` folder inside of the datapack, there will be a <samp>.lua</samp> file there.  
Open up your command prompt in that folder and run the following:
```sh
# Replace the $variables with numbers (100 = 100%)
# Interval starts counting from min, not 0.
lua build_scale_functions.lua $min $max $interval
```
A new folder called `build_out` will appear containing the result of running the script. If the contents of the folder
are to your liking, you can use the following to apply your changes:
```sh
lua build_scale_functions.lua apply
```
If you wish to reset to the defaults, simply run the script without any values.
```sh
lua build_scale_functions.lua
lua build_scale_functions.lua apply
```
