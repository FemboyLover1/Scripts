local path = PUT YOUR SCRIPT HERE
local function log()
    local returndata = nil
    for i,v in pairs(path:GetDescendants()) do
        if returndata == nil then
            returndata = "["..i.."] "..v:GetFullName().."\n"
        else
            returndata = returndata.."["..i.."] "..v:GetFullName().."\n"
        end
    end
    return returndata
end
setclipboard(log())
