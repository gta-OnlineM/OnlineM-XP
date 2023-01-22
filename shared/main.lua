Config = {}

Config.DebugCommands = true

-- Colors can be found at https://docs.fivem.net/docs/game-references/hud-colors/
Config.BarColor = 202
Config.IconColor = 48

Config.RankLimits = {}

local last = 0
for i=1, 300 --[[ Max Rank, set to your choosing]] do
    local add = 200
    -- These stack
    if i >  5 then add = add + 300 end -- 500
    if i >  10 then add = add + 400 end -- 900
    if i >  20 then add = add + 500 end -- 1400
    if i >  30 then add = add + 800 end -- 2200
    if i >  50 then add = add + 1000 end -- 3300
    Config.RankLimits[#Config.RankLimits + 1] = last + add -- add the limits to the last rank XP :)
    last += add
end
