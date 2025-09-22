-- shell.run("wget http://127.0.0.1:8080/code/printer/printer.lua")

local lib = {}
local printer
local xp = 1
local yp = 1
local shouldNewPage = false

function lib.init(side)
    printer = peripheral.wrap(side)
    if not printer then return nil end
    return true
end

function lib.setPrinterObject(obj)
    printer = obj
end

function lib.getPrinterObject()
    return printer
end

function lib.setPos(x, y)
    if x ~= nil then
        xp = x
    end
    if y ~= nil then
        yp = y
    end
    printer.setCursorPos(xp, yp)
end

function lib.getPos()
    return printer.getCursorPos()
end

function lib.startPage()
    xp = 1
    yp = 1
    local st = printer.newPage()
    printer.setCursorPos(xp, yp)
    shouldNewPage = false
    return st
end

function lib.endPage()
    printer.endPage()
    shouldNewPage = false
end

function lib.write(text)
    data = tostring(text)
    for i = 1, #data do
        lib.writeChar(data:sub(i, i))
    end
end

function lib.print(text)
    lib.write(text)
    lib.writeChar("\n")
end

function lib.printCenter(text)
    data = tostring(text)
    xp = 13-(math.floor(#data/2))
    lib.print(data)
end

-------------------

function lib.writeChar(char)
    if shouldNewPage then
        local st = false
        while st == false do
            st = printer.newPage()
        end
        printer.setCursorPos(1, 1)
        shouldNewPage = false
    end
    printer.setCursorPos(xp, yp)
    if char == "\n" then
        xp = 0
        yp = yp + 1
    else
        printer.write(char)
    end
    
    xp = xp + 1
    if xp >= 26 then
        xp = 1
        yp = yp + 1
    end
    if yp >= 22 then
        yp = 1
        shouldNewPage = true
    end
end

return lib
