#define objective svnet.peh_reset Resets all SvNPehkui scales

#define objective svnet.peh_all Sets the global scale
#define objective svnet.peh_all_w Sets the global width
#define objective svnet.peh_all_h Sets the global height
#define objective svnet.peh_mdl Sets the model scale
#define objective svnet.peh_mdl_w Sets the model width
#define objective svnet.peh_mdl_h Sets the model height
#define objective svnet.peh_phys Sets the physics scale
#define objective svnet.peh_phys_w Sets the physics width
#define objective svnet.peh_phys_h Sets the physics height
#define objective svnet.peh_bbox Sets the hitbox scale
#define objective svnet.peh_bbox_w Sets the hitbox width
#define objective svnet.peh_bbox_h Sets the hitbox height
#define objective svnet.peh_eye_h Sets the eye height
#define objective svnet.peh_motion Sets the motion scale
#define objective svnet.peh_reach Sets the reach scale
#define objective svnet.peh_proj Sets the projectile scale
#define objective svnet.peh_drops Sets the drops scale

#define objective svnpeh.limits Contains scale limits
#define score_holder #min Contains the minimum scale limit
#define score_holder #max Contains the maximum scale limit


data modify storage svnet:registry send append value "peh_reset"

data modify storage svnet:registry send append value "peh_all"
data modify storage svnet:registry send append value "peh_all_w"
data modify storage svnet:registry send append value "peh_all_h"
data modify storage svnet:registry send append value "peh_mdl"
data modify storage svnet:registry send append value "peh_mdl_w"
data modify storage svnet:registry send append value "peh_mdl_h"
data modify storage svnet:registry send append value "peh_phys"
data modify storage svnet:registry send append value "peh_phys_w"
data modify storage svnet:registry send append value "peh_phys_h"
data modify storage svnet:registry send append value "peh_bbox"
data modify storage svnet:registry send append value "peh_bbox_w"
data modify storage svnet:registry send append value "peh_bbox_h"
data modify storage svnet:registry send append value "peh_eye_h"
data modify storage svnet:registry send append value "peh_motion"
data modify storage svnet:registry send append value "peh_reach"
data modify storage svnet:registry send append value "peh_proj"
data modify storage svnet:registry send append value "peh_drops"


scoreboard objectives add svnet.peh_reset trigger "[ServerNet Pehkui] Reset Scales"

scoreboard objectives add svnet.peh_all trigger "[ServerNet Pehkui] Set Global Scale"
scoreboard objectives add svnet.peh_all_w trigger "[ServerNet Pehkui] Set Global Width"
scoreboard objectives add svnet.peh_all_h trigger "[ServerNet Pehkui] Set Global Height"
scoreboard objectives add svnet.peh_mdl trigger "[ServerNet Pehkui] Set Model Scale"
scoreboard objectives add svnet.peh_mdl_w trigger "[ServerNet Pehkui] Set Model Width"
scoreboard objectives add svnet.peh_mdl_h trigger "[ServerNet Pehkui] Set Model Height"
scoreboard objectives add svnet.peh_phys trigger "[ServerNet Pehkui] Set Physics Scale"
scoreboard objectives add svnet.peh_phys_w trigger "[ServerNet Pehkui] Set Physics Width"
scoreboard objectives add svnet.peh_phys_h trigger "[ServerNet Pehkui] Set Physics Height"
scoreboard objectives add svnet.peh_bbox trigger "[ServerNet Pehkui] Set Hitbox Scale"
scoreboard objectives add svnet.peh_bbox_w trigger "[ServerNet Pehkui] Set Hitbox Width"
scoreboard objectives add svnet.peh_bbox_h trigger "[ServerNet Pehkui] Set Hitbox Height"
scoreboard objectives add svnet.peh_eye_h trigger "[ServerNet Pehkui] Set Eye Height"
scoreboard objectives add svnet.peh_motion trigger "[ServerNet Pehkui] Set Motion Scale"
scoreboard objectives add svnet.peh_reach trigger "[ServerNet Pehkui] Set Reach Scale"
scoreboard objectives add svnet.peh_proj trigger "[ServerNet Pehkui] Set Projectile Scale"
scoreboard objectives add svnet.peh_drops trigger "[ServerNet Pehkui] Set Drops Scale"


scoreboard objectives add svnpeh.limits dummy "[SVNPehkui] Scale Limits"
execute unless score #min svnpeh.limits matches 25..300 run scoreboard players set #min svnpeh.limits 30
execute unless score #max svnpeh.limits matches 25..300 run scoreboard players set #max svnpeh.limits 250
