--[[
    [Q1] Fix or improve code

    Muhammad Naufal Pratama

    Explanation:
        This Q1 program supposes to do a player logout functionality.

        1. Call the OnLogout function and providing with a player object that we want to logout
        2. OnLogout will check if the player is currently login or not
        3. If the player is logged IN, do the logout process
        4. If the player is logged OUT, skip the logout process and return from the OnLogout function

    Run:    
        lua.exe Q1.lua
--]]

print("--------")
print(" Q1")
print("--------")

--[[
-- Player   : A "class" representing a Player object.
--          : Properties:
--          :           - id = the player unique id
--          :           - login_state = the player current login status
--          :               # 1 = logged IN
--          :               # -1 = logged OUT
--]]
Player = { id = "", login_state = -1 }

--[[
-- Player:new = function to initialize a new Player object. Returning the new Player object.
--      @player_id_ = player unique id that we want to assign
--      @login_state_ = player login status, default is -1
--]]
function Player:new(player_id_, login_state_)
    setmetatable({}, Player)

    self.id = player_id_
    self.login_state = login_state_

    return self
end

--[[
-- Player:get_id = function to get the current player id. Returning the current player id.
--]]
function Player:get_id()
    return self.id
end

--[[
-- Player:get_login_state = function to get the current player login status. Returning the current player login status.
--]]
function Player:get_login_state()
    return self.login_state
end

--[[
-- Player:set_login_state = function to set the current player login status.
--]]
function Player:set_login_state(new_login_state)
    if new_login_state == 1 or new_login_state == -1 then
        self.login_state = new_login_state
    end
end

--[[
-- Player:getStorageValue = function to get the login status of a player that we want to logging out.
--]]
function Player:getStorageValue(current_player)
    local login_status = current_player:get_login_state()
    local player_id = current_player:get_id()
    print("[INFO] Player of ID [" ..
        player_id .. "] logging status is: " .. (login_status == 1 and "Logged IN" or "Logged OUT"))
    return login_status
end

--[[
-- Player:setStorageValue = function to set the login status of a player that we want to logging out.
-- This function supposes to change the player login_state from 1 (logged IN) to -1 (logged OUT).
--]]
function Player:setStorageValue(current_player, new_login_state)
    current_player:set_login_state(new_login_state)
end

--[[
-- releaseStorage = function to call the setStorageValue that will change the player login_state.
--]]
local function releaseStorage(current_player)
    Player:setStorageValue(current_player, -1)
    return current_player
end

--[[
-- addEvent = function that supposes to call another service, telling that this player has already logout.
-- Since there's no other service here, I just print it to represent the message that we send to other services.
--]]
local function addEvent(current_player)
    print("[INFO] Player of ID [" .. current_player:get_id() .. "] successfully logged out!")
end

--[[
-- OnLogout: function to process the Player logging out mechanism.
--         : This function check if the current player is logged IN or not, which is indicated by number as follow:
--         : 1 => player is logged IN
--         : -1 => player is logged OUT
--         : After the loggin out process done, this function will notify other services by calling the addEvent()
--]]
function OnLogout(current_player)
    if Player:getStorageValue(current_player) == 1 then -- if the player is currently Logged IN
        addEvent(releaseStorage(current_player))        -- do logout and notify other services
        return true
    end

    print("[WARNING] Player of ID [" .. current_player:get_id() .. "] is already logged out")
    return false
end

--[[----]]--
--[[MAIN]]--
--[[----]]--
local player1 = Player:new(111, -1)
OnLogout(player1)

print("")

local player2 = Player:new(222, 1)
OnLogout(player2)
