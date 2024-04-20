--[[
    [Q3] Fix or improve the name and the implementation of the below method

    Muhammad Naufal Pratama

    Explanation:
        This Q3.lua program is suppose to do a party member kicking 

    Run:
        lua.exe Q3.lua
--]]

print("--------")
print(" Q3")
print("--------")

--[[
-- Parties = a "dummy" data that holds information about Party
--]]
Parties = {}

--[[
-- Players = a "dummy" data that holds information about Player
--]]
Players = {
    ["playerId"] = 123,
    ["membername"] = "member1",
    ["party"] = {
        "party1",
        "party2"
    }
}

--[[
-- Player = a function grab the Players object.
-- Ideally this function needs to do a Players searching based on the give query argument,
-- but since there's only one Players dummy data, so I just return it
--]]
function Player(query)
    print "[INFO] Getting a player"
    if query == Players["playerId"] or query == Players["membername"] then
        return Players
    end

    return nil
end

--[[
-- Players:getParty = a function that get all of the party that a player joined
-- Ideally this function needs to do a Parties search flow based on which player it is,
-- but since there's only one Players dummy data & one Parties dummy data, so I just return it
--]]
function Players:getParty()
    print "[INFO] Getting player parties"
    return Parties
end

--[[
-- Players:getMembers = a function that get all of the members of certain party.
-- Ideally this function needs to do a Pary member search mechanism,
-- but here I just set the Parties's member to Players.
--]]
function Parties:getMembers()
    print "[INFO] Getting party members"
    return { Parties = Players }
end

--[[
-- Players:removeMember = a function that remove the specified member from party
-- Ideally this function needs to do a Pary member search mechanism,
-- but here I just set the Parties's member to Players.
--]]
function Parties:removeMember(removePartyMember)
    print ("[INFO] Removing party member: " .. removePartyMember["membername"])
end

--[[
-- kick_party_member = a function that process the party member kicking
-- note: I rename the function name.
--]]
local function kick_party_member(playerId, membername)
    local player = Player(playerId)          -- take informations of a player that we want to kick from party
    if player == nil then                   -- if that player is exist in the "database", end this function
        return
    end

    local party = player:getParty()          -- search all party that player currently joined

    for k, v in pairs(party:getMembers()) do -- for all of the parties that the player joined
        if v == Player(membername) then      -- if player still exist in that party
            party:removeMember(v)            -- KICK that player
        end
    end
end

--[[----]]--
--[[MAIN]]--
--[[----]]--
kick_party_member(123, "member1")
