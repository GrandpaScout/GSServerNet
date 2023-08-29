execute as @a[scores={svnet.rocketjump=1..}] at @s run function my_namespace:svnet_rocketjump
scoreboard players set @a svnet.rocketjump 0
scoreboard players enable @a svnet.rocketjump

execute as @a[scores={svnet.nearestent=1..}] at @s run tellraw @s ["", {"translate": "", "font": "svnet:nearest_ent", "with": [{"selector": "@e[sort=nearest,limit=1,distance=0.05..]", "font": "svnet:selector"}]}]
scoreboard players set @a svnet.nearestent 0
scoreboard players enable @a svnet.nearestent
