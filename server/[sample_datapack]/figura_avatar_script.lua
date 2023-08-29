-- Require the ServerNet library.
local SVNet = require("GSServerNet")

local svnet_ready = false

-- Wait for ServerNet to connect.
SVNet.await(function(success)
  if success then svnet_ready = true end
end)

-- Receive `svnet:nearest_ent` messages and print the entity.
SVNet.receive("nearest_ent", function(_, ent)
  print("The nearest entity is", ent)
end)


-- Press G to rocket jump.
keybinds:newKeybind("Rocket Jump", "key.keyboard.g")
  :onPress(function()
    if svnet_ready then SVNet.send("rocketjump") end
  end)


-- Press N to get the nearest entity to yourself.
keybinds:newKeybind("Get Nearest Entity", "key.keyboard.n")
  :onPress(function()
    if svnet_ready then SVNet.send("nearestent") end
  end)
