local m = peripheral.find("modem")
--local m = peripheral.wrap(jside)
print("frq 10501-10551")
local frq  =  tonumber(io.read())
if not (frq >= 10501 and frq <= 10551) then
    error("choose a valid frequency!")
end
m.open(frq)

local msgBuffer = {}

parallel.waitForAny(
function()
    while true do
        print("Type your message:")
        local msg = io.read()
        m.transmit(frq, frq, {"dlhjs-ChrisHamRadio-dlhjs", msg})
        for i, v in pairs(msgBuffer) do
            print(v)
        end
        msgBuffer = {}
    end
end,
function()
    while true do
        local _, _, _, _, msg = os.pullEvent("modem_message")
        if type(msg)== "table" then
            if msg[1] == "dlhjs-ChrisHamRadio-dlhjs" then
                table.insert(msgBuffer, msg[2])
            end
        end
    end
end)
