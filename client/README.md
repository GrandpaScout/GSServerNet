##### Looking for the ServerNet Server for Minecraft Servers? Check out the `server` folder instead.

# GSServerNet Client
This folder contains the **GSServerNet** script for use on Figura Avatars.

## Quick Snippets

To begin using it, `require()` it in another script file.
```lua
local SVNet = require("GSServerNet")
```

You can then create receivers to run functions when certain messages are received from the ServerNet Server.
```lua
SVNet.receive("message_name", function(name, param1, param2, paramN, ...)
  -- Do stuff here
end)
```

You can also send messages to the server you are connected to.  
Do not attempt to send a message if you do not have a connection, it will throw an error.
```lua
SVNet.send("msg_name", 123)
```

You can detect when a successful ServerNet connection is made with `.await()`.
```lua
SVNet.await(function(success)
  if success then print("ServerNet connection was successful!") end
end)
```

## Examples
This script waits for the server to send the closest entity to the avatar and displays particles over it.
```lua
local SVNet = require("GSServerNet")

local target

SVNet.receive("nearest_ent", function(_, entity)
  target = entity
end)

function events.TICK()
  if target then
    particles:newParticle("witch", target:getPos():add(0, 2.2, 0))
  end
end
```

This script sends a message called "rocketjump" that will likely cause the player to be launched into the air by the
server.
```lua
local SVNet = require("GSServerNet")

local should_send = false

SVNet.await(function(success)
  should_send = success
end)

local key_rocketjump = keybinds:newKeybind("Rocket Jump", "key.keyboard.g")
function key_rocketjump.press()
  -- If this if statement wasn't here, `SVNet.send` would throw an error if
  -- no successful ServerNet connection has been made.
  if should_send then
    SVNet.send("rocketjump")
  end
end
```

## Configuration
Configuring ServerNet is *not* done by editing the script. Do not try it.

If you wish to edit how ServerNet works, you can access its config through the same variable you required.  
The descriptions and default values of every config option is shown below.  
`SVNet.config_key = possible_values  [type = default_value]`
```lua
local SVNet = require("GSServerNet")


-- Sets whether logging of ServerNet messages is enabled.
-- These logs look similar to ping logs.
--
-- Logs with `>>` are being sent to the server, logs with `<<` are being received from the server.
SVNet.log = true/false  [boolean = false]


-- Sets whether warning messages are suppressed.
--
-- Certain actions or functions will cause a warning to be printed into chat. These are similar to
-- errors but will not freeze your script. They are simply there to warn you of an issue.
SVNet.suppress_warnings = true/false  [boolean = false]


-- Sets the amount of ticks a sent message should wait before timing out and resolving.
-- If you are seeing trigger success or failure messages from the server in the in-game chat then
-- this is too low.
--
-- `timeout_errors` controls if a timeout causes messages to error instead of succeeding.
SVNet.timeout = 0..9223372036854775807  [integer = 5]


-- Sets if a sent message should error if it times out. This does *not* cause Lua errors.
--
-- The default makes timed out messages succeed because the only vanilla reason a message would
-- time out is if the server has the `sendCommandFeedback` gamerule set to `false`.
SVNet.timeout_errors = true/false  [boolean = false]


-- [DEBUG VALUE]
-- You likely don't need to mess with this unless you are developing with ServerNet.
--
-- Allows usage of the internal `svnet:_echo_` message. If this is used, it *must* be the first
-- component in a JSON array or the root component if using the `"extra"` tag.
-- This breaks the rules that every other message type follows to avoid its accidental usage.
SVNet.allow_echo = true/false  [boolean = false]


-- [DEBUG VALUE]
-- You likely don't need to mess with this unless you are developing with ServerNet.
--
-- Causes this library to print the contents of *every* chat message the client receives.
-- Does not print the contents of Lua prints to avoid endless loops.
SVNet.echo_all = true/false  [default = false]
```
