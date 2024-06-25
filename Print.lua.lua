--Very Basic Print API
local printer = peripheral.find("printer")
print("Basic PhileOS Print API")
print("V 1.0")
print("")
print("Save file to \"/print this\" to print.")

while true do
  if fs.exists("print this") then
    local fh = fs.open("print this", "r")
    printer.newPage()
    local x, y = printer.getPageSize()
    local line = fh.readLine()
    local linenum = 1
    while line ~= nil and linenum <= y do
      printer.setCursorPos(1, linenum)
      printer.write(line)
      linenum = linenum + 1
      line = fh.readLine()
    end
    printer.endPage()
    fh.close()
    fs.delete("print this")
  end
  os.sleep()
end