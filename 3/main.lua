local function read_file(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

local function calculate(str)
    local acc = 0
    for num1, num2 in str:gmatch("mul%((%d%d?%d?),(%d%d?%d?)%)") do
        acc = acc + tonumber(num1) * tonumber(num2)
    end
    return acc
end

local inputText = read_file("input.txt")
local cleanText = inputText:gsub("don%'t%(%)(.-)do%(%)", ""):gsub("don%'t%(%).*", "")

print(calculate(inputText)) -- Part 1
print(calculate(cleanText)) -- Part 2
