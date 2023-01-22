--[[OnlineM-XP -> Scaleform XP System

Copyright (C) 2023 Mycroft (kasey Fitton)

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see <http://www.gnu.org/licenses/>.]]
local prev_xp = LocalPlayer.state.xp or 0

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("onlineM-xp:Spawned")
end)

RegisterNetEvent("onlineM-xp:showBar", ShowXPBar)

function ShowXPBar(Duration, speed, BarText)
    RequestScaleformScriptHudMovie(19)
    while not HasScaleformScriptHudMovieLoaded(19) do
       Wait(0)
    end
    local currXP = math.floor(LocalPlayer.state.xp + 0.5)
    local currank = LocalPlayer.state.rank
    BeginScaleformScriptHudMovieMethod(19, "SET_COLOUR")
    ScaleformMovieMethodAddParamInt(Config.BarColor)
    ScaleformMovieMethodAddParamInt(Config.IconColor) -- blue
    EndScaleformMovieMethod()

    BeginScaleformScriptHudMovieMethod(19, "RESET_BAR_TEXT")
    EndScaleformMovieMethod()

    if BarText then
        BeginScaleformScriptHudMovieMethod(19, "SET_BAR_TEXT")
        ScaleformMovieMethodAddParamPlayerNameString(BarText)
        EndScaleformMovieMethod()
    end

    BeginScaleformScriptHudMovieMethod(19, "OVERRIDE_ANIMATION_SPEED")
    ScaleformMovieMethodAddParamInt(speed ~= nil and speed or 1000) -- Current Rank Limit
    EndScaleformMovieMethod()

    BeginScaleformScriptHudMovieMethod(19, "OVERRIDE_ONSCREEN_DURATION")
    ScaleformMovieMethodAddParamInt(Duration ~= nil and Duration or 5000) -- Current Rank Limit
    EndScaleformMovieMethod()

    BeginScaleformScriptHudMovieMethod(19, "SET_RANK_SCORES")
    ScaleformMovieMethodAddParamInt(Config.RankLimits[currank]) -- Current Rank Limit
    ScaleformMovieMethodAddParamInt(Config.RankLimits[currank + 1]) -- Next Rank Limit

    ScaleformMovieMethodAddParamInt(prev_xp) -- Previous 
    ScaleformMovieMethodAddParamInt(currXP) -- Current XP
    ScaleformMovieMethodAddParamInt(currank) -- Curr Rank
    EndScaleformMovieMethod()
    
    prev_xp = currXP
end

if Config.DebugCommands then
    RegisterCommand("showxp", function()
        ShowXPBar()
    end)

    -- args: 1 - Duration (ms)
    RegisterCommand("showxpwithduration", function(src, args)
        ShowXPBar(tonumber(args[1]))
    end)
    -- args: 2 - Speed (ms)
    RegisterCommand("showxpwithspeed", function(src, args)
        ShowXPBar(nil, tonumber(args[1]))
    end)
    -- args: 1 - Text
    RegisterCommand("showxpwithtext", function(_, _, raw)
        local text = string.gsub(tostring(raw), "showxpwithtext", "")
        ShowXPBar(nil, nil, text)
    end)
end

exports("showBar", ShowXPBar)