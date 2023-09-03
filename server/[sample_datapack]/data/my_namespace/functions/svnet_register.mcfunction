data modify storage svnet:registry modules append value "MyModule"

data modify storage svnet:registry receive append value "nearest_ent"

scoreboard objectives add svnet.rocketjump trigger "[ServerNet] Rocket Jump"
data modify storage svnet:registry send append value "rocketjump"
scoreboard objectives add svnet.nearestent trigger "[ServerNet] Get Nearest Entity"
data modify storage svnet:registry send append value "nearestent"
