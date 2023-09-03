execute as @a[scores={svnet.peh_reset=1..}] run function svn_pehkui:scale/reset
scoreboard players set @a svnet.peh_reset 0
scoreboard players enable @a svnet.peh_reset

execute as @a[scores={svnet.peh_all=1..}] run function svn_pehkui:scale/select_all
scoreboard players set @a svnet.peh_all 0
scoreboard players enable @a svnet.peh_all

execute as @a[scores={svnet.peh_all_w=1..}] run function svn_pehkui:scale/select_all_w
scoreboard players set @a svnet.peh_all_w 0
scoreboard players enable @a svnet.peh_all_w

execute as @a[scores={svnet.peh_all_h=1..}] run function svn_pehkui:scale/select_all_h
scoreboard players set @a svnet.peh_all_h 0
scoreboard players enable @a svnet.peh_all_h

execute as @a[scores={svnet.peh_mdl=1..}] run function svn_pehkui:scale/select_mdl
scoreboard players set @a svnet.peh_mdl 0
scoreboard players enable @a svnet.peh_mdl

execute as @a[scores={svnet.peh_mdl_w=1..}] run function svn_pehkui:scale/select_mdl_w
scoreboard players set @a svnet.peh_mdl_w 0
scoreboard players enable @a svnet.peh_mdl_w

execute as @a[scores={svnet.peh_mdl_h=1..}] run function svn_pehkui:scale/select_mdl_h
scoreboard players set @a svnet.peh_mdl_h 0
scoreboard players enable @a svnet.peh_mdl_h

execute as @a[scores={svnet.peh_phys=1..}] run function svn_pehkui:scale/select_phys
scoreboard players set @a svnet.peh_phys 0
scoreboard players enable @a svnet.peh_phys

execute as @a[scores={svnet.peh_phys_w=1..}] run function svn_pehkui:scale/select_phys_w
scoreboard players set @a svnet.peh_phys_w 0
scoreboard players enable @a svnet.peh_phys_w

execute as @a[scores={svnet.peh_phys_h=1..}] run function svn_pehkui:scale/select_phys_h
scoreboard players set @a svnet.peh_phys_h 0
scoreboard players enable @a svnet.peh_phys_h

execute as @a[scores={svnet.peh_bbox=1..}] run function svn_pehkui:scale/select_bbox
scoreboard players set @a svnet.peh_bbox 0
scoreboard players enable @a svnet.peh_bbox

execute as @a[scores={svnet.peh_bbox_w=1..}] run function svn_pehkui:scale/select_bbox_w
scoreboard players set @a svnet.peh_bbox_w 0
scoreboard players enable @a svnet.peh_bbox_w

execute as @a[scores={svnet.peh_bbox_h=1..}] run function svn_pehkui:scale/select_bbox_h
scoreboard players set @a svnet.peh_bbox_h 0
scoreboard players enable @a svnet.peh_bbox_h

execute as @a[scores={svnet.peh_eye_h=1..}] run function svn_pehkui:scale/select_eye_h
scoreboard players set @a svnet.peh_eye_h 0
scoreboard players enable @a svnet.peh_eye_h

execute as @a[scores={svnet.peh_motion=1..}] run function svn_pehkui:scale/select_motion
scoreboard players set @a svnet.peh_motion 0
scoreboard players enable @a svnet.peh_motion

execute as @a[scores={svnet.peh_reach=1..}] run function svn_pehkui:scale/select_reach
scoreboard players set @a svnet.peh_reach 0
scoreboard players enable @a svnet.peh_reach

execute as @a[scores={svnet.peh_proj=1..}] run function svn_pehkui:scale/select_proj
scoreboard players set @a svnet.peh_proj 0
scoreboard players enable @a svnet.peh_proj

execute as @a[scores={svnet.peh_drops=1..}] run function svn_pehkui:scale/select_drops
scoreboard players set @a svnet.peh_drops 0
scoreboard players enable @a svnet.peh_drops
