--[[
    [Q2] Fix or improve code

    Muhammad Naufal Pratama

    Explanation:
        This Q2.lua program supposes to do a guilds searching.

    Run:
        lua.exe Q2.lua
--]]

print("--------")
print(" Q2")
print("--------")

--[[
-- guilds = a "dummy" data that holds information about all Guilds
--]]
local guilds = {
    { ["name"] = "Guilds1", ["memberCount"] = 10 },
    { ["name"] = "Guilds2", ["memberCount"] = 20 },
    { ["name"] = "Guilds3", ["memberCount"] = 55 },
    { ["name"] = "Guilds4", ["memberCount"] = 5 },
    { ["name"] = "Guilds5", ["memberCount"] = 13 },
    { ["name"] = "Guilds6", ["memberCount"] = 2 }
}

--[[
-- doStoreQuery = a function to search guilds that have memberCount less than maxMember
--]]
local function doStoreQuery(query_)
    if query_ ~= nil then                                           -- if query_ is nil, do nothing and return
        local maxMember = string.match(query_, "%d+")               -- grab the maxMember integer

        local result = ""
        for i = 1, #guilds do                                       -- for each data inside guilds
            if guilds[i]["memberCount"] < tonumber(maxMember) then  -- check if the current guild's memberCount is less than the maxMember
                result = result .. guilds[i]["name"] .. " "         -- append the guild name to the result string
            end
        end

        return result
    end
end

--[[
-- db = a function table that holds information of all function in this program
--]]
local db = {
    storeQuery = doStoreQuery
}

--[[
-- printSmallGuildNames = function that suppose to get name of all guilds that have memberCount less thank maxMember
--]]
local function printSmallGuildNames(maxMember)
    local selectGuildQuery = "SELECT name FROM guilds WHERE memberCount < %d;"
    local result = db.storeQuery(string.format(selectGuildQuery, maxMember))
    print(result)
end

--[[----]]--
--[[MAIN]]--
--[[----]]--
printSmallGuildNames(13)
