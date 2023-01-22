<h1 align='center'>[OnlineM] Scaleform XP System</a></h1><p align='center'><b>Documenation</b></h5>

# Getting Rank and XP

> All real-time Rank and XP data are stored in statebags!

## Client Side

```lua
-- Get Rank
LocalPlayer.state.rank

-- Get XP
LocalPlayer.state.xp
```

## Server Side

```lua
-- Get Rank
Player(PlayerId).state.rank

-- Get XP
Player(PlayerId).state.xp
```

# Adding XP (Server-Side)

## Exports

### addXP

```lua
exports["OnlineM-XP"]:addXP(PlayerId, Amount)
```

### getNextAvailableRankUp

> Gets the rank the user will recieve if they recieve a certain amount of XP

```lua
exports["OnlineM-XP"]:getNextAvailableRankUp(currentRank, XPamount)
```
## Statebags

> You Can Easily give a player XP by using state bags!

```lua
Player(PlayerId).state.addXP(amount)
```

# Removing XP (Server-Side)

## Exports

### removeXP

```lua
exports["OnlineM-XP"]:removeXP(PlayerId, Amount)
```

### getNextAvailableRankDown

> Gets the rank the user will recieve if they loose a certain amount of XP

```lua
exports["OnlineM-XP"]:getNextAvailableRankDown(currentRank, XPamount)
```

## Statebags

> You Can Easily remove XP from a player by using state bags!

```lua
Player(PlayerId).state.removeXP(amount)
```

# Showing XP (Client-Side)

> You Can show the XP bar Using the `showBar` export or the `onlineM-xp:showBar` event

## Arguments

| Argument  | Data Type | Optional | Default Value |                     Explanation                       |
|-----------|-----------|----------|---------------|-------------------------------------------------------|
| Duration  | number    | Yes      | 5000          | The Time in milliseconds that it shows on the screen  |
| speed     | number    | Yes      | 1000          | The Animation Speed in milliseconds                   |
| BarText   | String    | Yes      | Current XP    | The Text to show under the Bar                        |

```lua
exports["OnlineM-XP"]:showBar(Duration, speed, BarText)

-- for default bar:
exports["OnlineM-XP"]:showBar()
````

```lua
TriggerEvent("onlineM-xp:showBar", Duration, speed, BarText)

-- for default bar:
TriggerEvent("onlineM-xp:showBar")
````




