# DON'T MODIFY THIS FILE.
# -----------------------
# If you wish to add functions that should run when a new client connects to ServerNet,
# add it to the `#svnet:start` function tag and it will run automatically.
#
# `@s` will be the client that connected to ServerNet.
# The execution position will be placed on the client.
#
# [!! READ THE README FILE FOR MORE INFORMATION !!]

# Set the connection status of this client.
scoreboard players set @s svnet_connected 1

# Send the registry to new clients.
tellraw @s {"translate":"","font":"svnet:_registry_","with":[{"font":"svnet:number","storage":"svnet:registry","nbt":"protocol"},{"font":"svnet:array","storage":"svnet:registry","nbt":"receive","interpret":true},{"font":"svnet:array","storage":"svnet:registry","nbt":"send","interpret":true}]}

# Run all start functions.
function #svnet:start
