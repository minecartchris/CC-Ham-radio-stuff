print("HAM Radio checker")

local modem = peripheral.wrap("left")
for ch = 10501, 10551 do
    modem.open(ch)
end

local admin_pass = "iphone20.5.7"

modem.open(10553)
modem.transmit(10552, 10553, {"GET", "", admin_pass})
local reply = {os.pullEvent("modem_message")}
local database = textutils.unserialise(reply[5])
modem.close(10553)


while true do
    local _, _, ch, _, msg, dist = os.pullEvent("modem_message")
    if type(msg) == "table" then
        if msg[1] == "dlhjs-ChrisHamRadio-dlhjs" then
            local text = msg[2]
            local bad = true
            for i, v in pairs(database) do
                if string.find(text, v[2]) then
                    bad = false
                end
            end
            if bad then
                print("Invalid Message! On Channel "..ch)
                print("Distance: "..dist)
                print("Sent: "..text)
                print("")
            end
        end
    end
end
