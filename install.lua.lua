--Print API Installer

local diskDir = shell.getRunningProgram():sub(1, -12)
if not PhileOS then
  error("Only for PhileOS Computers")
end

fs.copy(diskDir.."Print.lua", "PhileOS/SysPrograms/Print.lua")
fs.copy(diskDir.."icon.phimg", "PhileOS/Icons/Programs/PhileOS/SysPrograms/Print.lua.phimg")

local user = PhileOS.getUsername()
local file = 0
if user == "" then
    file = fs.open("/PhileOS/Settings/desktop.set", "r")
else
    file = fs.open("/PhileOS/Users/"..user.."/desktop.set", "r")
end
local pins = textutils.unserialise(file.readAll())
file.close()
local name = "Print"
table.insert(pins[1], {name, "PhileOS/SysPrograms/Print.lua"})
local file = 0
if user == "" then
    file = fs.open("/PhileOS/Settings/desktop.set", "w")
else
    file = fs.open("/PhileOS/Users/"..user.."/desktop.set", "w")
end
file.write(textutils.serialise(pins))
file.close()