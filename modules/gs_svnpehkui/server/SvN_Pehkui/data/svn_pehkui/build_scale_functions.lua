local args = {...}

local min, max = tonumber(args[1]) or 25, tonumber(args[2]) or 300
local interval = tonumber(args[3]) or 5

local cwd = os.getenv("PWD")
if not cwd then
  local pcwd = io.popen("cd", "r")
  if pcwd then
    cwd = pcwd:read()
    pcwd:close()
  end

  if not cwd or cwd == "" then error("could not get current directory", 2) end
end

if not cwd:match("svn_pehkui$") then error("the current directory is not the svn_pehkui folder") end

local is_unix = package.config:match("^/") and true or false

if args[1] == "apply" then
  if is_unix then
    os.execute("rm -rf ./functions")
  else
    os.execute("RMDIR /S /Q functions")
  end

  os.rename("build_out", "functions")
  print("Done. ./build_out/ moved to ./functions/")
  return
end

---Un-indents the given string.
---@param s string
---@return string
local function ui(s) return (s:gsub("^ +", ""):gsub("\n +", "\n")) end

---Removes the last newline
---@param s string
---@return string
local function nl(s) return (s:gsub("\r?\n$", "")) end


local functions = {
  {
    name = "all",
    define = "Sets the global scale",
    display = "Set Global Scale",
    type = "file",
    content = ui[[
      scale set pehkui:model_width %0.2f @s
      scale set pehkui:model_height %0.2f @s
      scale set pehkui:hitbox_width %0.2f @s
      scale set pehkui:hitbox_height %0.2f @s
      scale set pehkui:eye_height %0.2f @s
      scale set pehkui:motion %0.2f @s
      scale set pehkui:reach %0.2f @s
      scale set pehkui:projectiles %0.2f @s
      scale set pehkui:drops %0.2f @s
    ]]
  },
  {
    name = "all_w",
    define = "Sets the global width",
    display = "Set Global Width",
    type = "file",
    content = ui[[
      scale set pehkui:model_width %0.2f @s
      scale set pehkui:hitbox_width %0.2f @s
    ]]
  },
  {
    name = "all_h",
    define = "Sets the global height",
    display = "Set Global Height",
    type = "file",
    content = ui[[
      scale set pehkui:model_height %0.2f @s
      scale set pehkui:hitbox_height %0.2f @s
      scale set pehkui:eye_height %0.2f @s
      scale set pehkui:motion %0.2f @s
      scale set pehkui:reach %0.2f @s
    ]]
  },
  {
    name = "mdl",
    define = "Sets the model scale",
    display = "Set Model Scale",
    type = "file",
    content = ui[[
      scale set pehkui:model_width %0.2f @s
      scale set pehkui:model_height %0.2f @s
    ]]
  },
  {
    name = "mdl_w",
    define = "Sets the model width",
    display = "Set Model Width",
    type = "line",
    content = [[scale set pehkui:model_width %0.2f @s]]
  },
  {
    name = "mdl_h",
    define = "Sets the model height",
    display = "Set Model Height",
    type = "line",
    content = [[scale set pehkui:model_height %0.2f @s]]
  },
  {
    name = "phys",
    define = "Sets the physics scale",
    display = "Set Physics Scale",
    type = "file",
    content = ui[[
      scale set pehkui:hitbox_width %0.2f @s
      scale set pehkui:hitbox_height %0.2f @s
      scale set pehkui:eye_height %0.2f @s
      scale set pehkui:motion %0.2f @s
      scale set pehkui:reach %0.2f @s
      scale set pehkui:projectiles %0.2f @s
      scale set pehkui:drops %0.2f @s
    ]]
  },
  {
    name = "phys_w",
    define = "Sets the physics width",
    display = "Set Physics Width",
    type = "line",
    content = [[scale set pehkui:hitbox_width %0.2f @s]]
  },
  {
    name = "phys_h",
    define = "Sets the physics height",
    display = "Set Physics Height",
    type = "file",
    content = [[
      scale set pehkui:hitbox_height %0.2f @s
      scale set pehkui:eye_height %0.2f @s
      scale set pehkui:motion %0.2f @s
      scale set pehkui:reach %0.2f @s
    ]]
  },
  {
    name = "bbox",
    define = "Sets the hitbox scale",
    display = "Set Hitbox Scale",
    type = "file",
    content = [[
      scale set pehkui:hitbox_width %0.2f @s
      scale set pehkui:hitbox_height %0.2f @s
    ]]
  },
  {
    name = "bbox_w",
    define = "Sets the hitbox width",
    display = "Set Hitbox Width",
    type = "line",
    content = [[scale set pehkui:hitbox_width %0.2f @s]]
  },
  {
    name = "bbox_h",
    define = "Sets the hitbox height",
    display = "Set Hitbox Height",
    type = "line",
    content = [[scale set pehkui:hitbox_height %0.2f @s]]
  },
  {
    name = "eye_h",
    define = "Sets the eye height",
    display = "Set Eye Height",
    type = "line",
    content = [[scale set pehkui:eye_height %0.2f @s]]
  },
  {
    name = "motion",
    define = "Sets the motion scale",
    display = "Set Motion Scale",
    type = "line",
    content = [[scale set pehkui:motion %0.2f @s]]
  },
  {
    name = "reach",
    define = "Sets the reach scale",
    display = "Set Reach Scale",
    type = "line",
    content = [[scale set pehkui:reach %0.2f @s]]
  },
  {
    name = "proj",
    define = "Sets the projectile scale",
    display = "Set Projectile Scale",
    type = "line",
    content = [[scale set pehkui:projectiles %0.2f @s]]
  },
  {
    name = "drops",
    define = "Sets the drops scale",
    display = "Set Drops Scale",
    type = "line",
    content = [[scale set pehkui:drops %0.2f @s]]
  }
}



local file_register = [[
#define objective svnet.peh_reset Resets all SvNPehkui scales

%s

#define objective svnpeh.limits Contains scale limits
#define score_holder #min Contains the minimum scale limit
#define score_holder #max Contains the maximum scale limit


data modify storage svnet:registry modules append value "SvNPehkui"


data modify storage svnet:registry send append value "peh_reset"

%s


scoreboard objectives add svnet.peh_reset trigger "[ServerNet Pehkui] Reset Scales"

%s


scoreboard objectives add svnpeh.limits dummy "[SVNPehkui] Scale Limits"
execute unless score #min svnpeh.limits matches %d..%d run scoreboard players set #min svnpeh.limits 30
execute unless score #max svnpeh.limits matches %d..%d run scoreboard players set #max svnpeh.limits 250
]]

local register_define = [[#define objective svnet.peh_%s %s]]
local register_registry = [[data modify storage svnet:registry send append value "peh_%s"]]
local register_objective = [[scoreboard objectives add svnet.peh_%s trigger "[ServerNet Pehkui] %s"]]

local file_tick = [[
execute as @a[scores={svnet.peh_reset=1..}] run function svn_pehkui:scale/reset
scoreboard players set @a svnet.peh_reset 0
scoreboard players enable @a svnet.peh_reset

%s
]]

local tick_chunk = nl[[
execute as @a[scores={svnet.peh_%s=1..}] run function svn_pehkui:scale/select_%s
scoreboard players set @a svnet.peh_%s 0
scoreboard players enable @a svnet.peh_%s
]]

local file_select = [[
scoreboard players operation @s svnet.peh_%s > #min svnpeh.limits
scoreboard players operation @s svnet.peh_%s < #max svnpeh.limits
scale persist set true @s

%s
]]

local select_line = [[execute if score @s svnet.peh_%s matches %s run %s]]

local select_single = [[%d]]
local select_range = [[%d..%d]]
local select_first = [[..%d]]
local select_last = [[%d..]]

local select_function = [[function svn_pehkui:scale/%s/%d]]

if is_unix then
  os.execute("rm -rf ./build_out")
  os.execute("mkdir -p ./build_out/scale")
else
  os.execute("RMDIR /S /Q build_out")
  os.execute("MKDIR build_out\\scale")
end

local define_chunks = {}
local registry_chunks = {}
local scoreboard_chunks = {}
local tick_chunks = {}

local name, content
local select_chunks
local file, path
for _, func in ipairs(functions) do
  name = func.name
  content = func.content

  define_chunks[#define_chunks+1] = register_define:format(name, func.define)
  registry_chunks[#registry_chunks+1] = register_registry:format(name)
  scoreboard_chunks[#scoreboard_chunks+1] = register_objective:format(name, func.display)
  tick_chunks[#tick_chunks+1] = tick_chunk:format(name, name, name, name)

  select_chunks = {}
  if func.type == "file" then
    if is_unix then
      os.execute("mkdir ./build_out/scale/" .. name)
    else
      os.execute("MKDIR build_out\\scale\\" .. name)
    end
    path = "build_out/scale/" .. name .. "/"

    local nf
    for n = min, max, interval do
      nf = n * 0.01
      select_chunks[#select_chunks+1] = select_line:format(
        name,
        n <= min and select_first:format(n + interval - 1)
          or interval == 1 and select_single:format(n)
          or (n + interval - 1) >= max and select_last:format(n)
          or select_range:format(n, n + interval - 1),
        select_function:format(name, n)
      )

      file = io.open(path .. n .. ".mcfunction", "w")
      if not file then error("Failed to open file '" .. (path .. n .. ".mcfunction") ..  "'") end
      file:write(content:format(nf, nf, nf, nf, nf, nf, nf, nf, nf))
      file:close()
    end

    file = io.open("build_out/scale/select_" .. name .. ".mcfunction", "w")
    if not file then
      error("Failed to open file '" .. ("build_out/scale/select_" .. name .. ".mcfunction") ..  "'")
    end
    file:write(file_select:format(
      name, name,
      table.concat(select_chunks, "\n")
    ))
    file:close()
  else
    local nf
    for n = min, max, interval do
      nf = n * 0.01
      select_chunks[#select_chunks+1] = select_line:format(
        name,
        n <= min and select_first:format(n + interval - 1)
          or interval == 1 and select_single:format(n)
          or (n + interval - 1) >= max and select_last:format(n)
          or select_range:format(n, n + interval - 1),
        content:format(nf)
      )
    end

    file = io.open("build_out/scale/select_" .. name .. ".mcfunction", "w")
    if not file then
      error("Failed to open file '" .. ("build_out/scale/select_" .. name .. ".mcfunction") ..  "'")
    end
    file:write(file_select:format(
      name, name,
      table.concat(select_chunks, "\n")
    ))
    file:close()
  end
end

file = io.open("build_out/register.mcfunction", "w")
if not file then error("Failed to open file 'build_out/register.mcfunction'") end
file:write(file_register:format(
  table.concat(define_chunks, "\n"),
  table.concat(registry_chunks, "\n"),
  table.concat(scoreboard_chunks, "\n"),
  min, max, min, max
))
file:close()

file = io.open("build_out/tick.mcfunction", "w")
if not file then error("Failed to open file 'build_out/tick.mcfunction'") end
file:write(file_tick:format(table.concat(tick_chunks, "\n\n")))
file:close()

file = io.open("build_out/scale/reset.mcfunction", "w")
if not file then error("Failed to open file 'build_out/scale/reset.mcfunction'") end
file:write([[
scale persist reset pehkui:model_width @s
scale persist reset pehkui:model_height @s
scale persist reset pehkui:hitbox_width @s
scale persist reset pehkui:hitbox_height @s
scale persist reset pehkui:eye_height @s
scale persist reset pehkui:motion @s
scale persist reset pehkui:reach @s
scale persist reset pehkui:projectiles @s
scale persist reset pehkui:drops @s

scale reset pehkui:model_width @s
scale reset pehkui:model_height @s
scale reset pehkui:hitbox_width @s
scale reset pehkui:hitbox_height @s
scale reset pehkui:eye_height @s
scale reset pehkui:motion @s
scale reset pehkui:reach @s
scale reset pehkui:projectiles @s
scale reset pehkui:drops @s
]])
file:close()

print("Done. Check ./build_out/")
