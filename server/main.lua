--[[OnlineM-XP -> Scaleform XP System

Copyright (C) 2023 Mycroft (kasey Fitton)

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see <http://www.gnu.org/licenses/>.]]

function Load(player)
    local identifier = GetPlayerLicense(player)
    if not identifier then
         return
    end
    local xp = 0
    local rank = 1
    local data = MySQL.query.await("SELECT * FROM user_xp WHERE identifier = ?", {identifier})

    if data and data[1] then
        xp = data[1].xp
        rank = data[1].rank
    else
        MySQL.insert("INSERT INTO user_xp (identifier) VALUES (?)", {identifier})
    end

    Player(player).state:set("xp", xp, true)
    Player(player).state:set("rank", rank, true)
    Player(player).state:set("addXP", function(amount)
        AddXP(player, amount)
    end, false)
    Player(player).state:set("removeXP", function(amount)
        RemoveXP(player, amount)
    end, false)
    TriggerClientEvent("onlineM-xp:showBar", player)
end

function GetPlayerLicense(player)
    for k, v in ipairs(GetPlayerIdentifiers(player)) do
        if string.match(v, 'license:') then
            return v
        end
    end
    return nil
end

RegisterNetEvent("onlineM-xp:Spawned", function()
   local source = source
   Load(source)
end)

function GetNextAvailableRankUp(currentRank, xp)
    for i=currentRank, #Config.RankLimits do
        if not Config.RankLimits[i + 1] then
            return i
        end
        local above = Config.RankLimits[i + 1]
        local curr = Config.RankLimits[i]
        if xp >= curr and xp < above then
            return i
        end
    end
end

function GetNextAvailableRankDown(currentRank, xp)
    for i=currentRank, 1, -1 do
        if not Config.RankLimits[i - 1] then
            return i
        end
        local bellow = Config.RankLimits[i - 1]
        local curr = Config.RankLimits[i]

        if xp >= curr and xp > bellow then
            return i
        end
    end
end

AddEventHandler("onResourceStop", function(name)
    if name ~= GetCurrentResourceName() then
        return
    end
    for _, playerId in pairs(GetPlayers()) do
        local licence = GetPlayerLicense(playerId)
        local xp = Player(playerId).state.xp
        local rank = Player(playerId).state.rank
        MySQL.update('UPDATE `user_xp` SET `xp` = ?, `rank` = ? WHERE `identifier` = ?', {xp, rank, licence})
    end
end)

AddEventHandler('playerDropped', function(reason)
    local _source = source
    local licence = GetPlayerLicense(_source)
    local xp = Player(_source).state.xp
    local rank = Player(_source).state.rank
    MySQL.update('UPDATE `user_xp` SET `xp` = ?, `rank` = ? WHERE `identifier` = ?', {xp, rank, licence})
end)

CreateThread(function()
    for _, playerId in pairs(GetPlayers()) do
        Load(playerId)
    end
end)

function AddXP(player, amount)
    local CurrentXP = Player(player).state.xp
    local NewXP = CurrentXP + amount
    Player(player).state:set("xp", NewXP, true)
    local currRank = Player(player).state.rank
    if NewXP >= Config.RankLimits[currRank + 1] then
        local Rank = GetNextAvailableRankUp(currRank, NewXP)
        Player(player).state:set("rank", Rank, true)
    end
    TriggerClientEvent("onlineM-xp:showBar", player)
end

function RemoveXP(player, amount)
    local CurrentXP = Player(player).state.xp
    local NewXP = CurrentXP - amount
    if NewXP < 0 then 
        NewXP = 0 
    end
    Player(player).state:set("xp", NewXP, true)
    local currRank = Player(player).state.rank
    local Rank = GetNextAvailableRankDown(currRank, NewXP)
    Player(player).state:set("rank", Rank, true)
    TriggerClientEvent("onlineM-xp:showBar", player)
end

if Config.DebugCommands then
    RegisterCommand("addxp", function(source, args)
        Player(source).state.addXP(tonumber(args[1]))
    end)
    
    RegisterCommand("removexp", function(source, args)
        Player(source).state.removeXP(tonumber(args[1]))
    end)
end

exports("addXP", AddXP)
exports("removeXP", RemoveXP)
exports("GetNextAvailableRankUp", GetNextAvailableRankUp)
exports("GetNextAvailableRankDown", GetNextAvailableRankDown)

