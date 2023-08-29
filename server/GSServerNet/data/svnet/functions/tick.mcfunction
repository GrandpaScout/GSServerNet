# DON'T MODIFY THIS FILE.
# -----------------------
# If you wish to add functions that run every tick after a ServerNet heartbeat,
# add it to the `#svnet:tick` function tag and it will run automatically.
#
# [!! READ THE README FILE FOR MORE INFORMATION !!]

# Detect new clients.
execute as @a[scores={svnet._start_=1}] at @s run function svnet:start
scoreboard players set @a svnet._start_ 0
scoreboard players enable @a svnet._start_

# Heartbeat
scoreboard players reset * svnet_heartbeat
scoreboard players set @a[scores={svnet_connected=1}] svnet_heartbeat 1
scoreboard players reset * svnet_connected
scoreboard players set @a[scores={svnet_heartbeat=1}] svnet_connected 1


# Run all tick functions.
function #svnet:tick
