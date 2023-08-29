#define storage svnet:registry Contains data for the server-side of ServerNet
#define tag/function #svnet:start Functions that should run when ServerNet gets a new connection
#define tag/function #svnet:register Functions that create a new ServerNet message
#define tag/function #svnet:tick Functions that should run after each ServerNet heartbeat

# DON'T MODIFY THIS FILE.
# -----------------------
# If you wish to modify the registry, add a function to the `#svnet:register` and define your messages there.
#
# `data modify storage svnet:registry receive append value "message_name"`
# Defines a new message that the server sends to clients.
#
# `data modify storage svnet:registry send append value "message_name"`
# Defines a new message that clients send to the server.
#
# [!! READ THE README FILE FOR MORE INFORMATION !!]

# Creates a score that keeps track of a client's connection to ServerNet.
scoreboard objectives add svnet_connected dummy "[ServerNet] Connection Status"

# Creates a score that keeps track of connected players.
scoreboard objectives add svnet_heartbeat dummy "[ServerNet] Connection Heartbeat"

# Creates the base svnet message. This message is sent by every client that connects to ServerNet.
scoreboard objectives add svnet._start_ trigger "[ServerNet] New User Connected"

# Sets the protocol version.
data modify storage svnet:registry protocol set value 1

# Creates the receiver registry.
data modify storage svnet:registry receive set value []

# Creates the sender registry.
data modify storage svnet:registry send set value []


# Run all register functions.
function #svnet:register
