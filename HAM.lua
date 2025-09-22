local modem = peripheral.wrap("top")
modem.closeAll()

local printer = require("/PrinterLib")

local charset = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
local output = ""

local password = "1324"
local admin_pass = "iphone20.5.7"

print("password")
local up = io.read()

if not (up == password) then
    printError("Invalid password")
    return
end

for i = 1,5 do
    local rnd = math.random(1,62)
    output = output..charset:sub(rnd,rnd)
end

term.clear()
term.setCursorPos(1,1)

write("Name: ")
local name = read()

modem.open(10553)
modem.transmit(10552, 10553, {"GET", "", admin_pass})
local reply = {os.pullEvent("modem_message")}
local fr = reply[5]
local db = textutils.unserialise(fr)
modem.closeAll()

table.insert(db, {name, output})

local fw = textutils.serialise(db)
modem.transmit(10552, 10553, {"POST", fw, admin_pass})

printer.setPrinterObject(peripheral.find("printer"))
printer.startPage()
printer.setPos(1,4)

printer.printCenter("Ham Radio License Code")
printer.setPos(1,10)
printer.printCenter(name)
printer.printCenter(output)

local po = printer.getPrinterObject()
po.setPageTitle("HAM Licence")

printer.endPage()

-- Code made by Hunter Turner (HuntaBadday)
