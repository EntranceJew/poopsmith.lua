# poopsmith.lua
The much less useful alternative to strict.lua

Because having a bunch of globals is messy.

Drop this in and any project that relies on globals will be rendered inoperable until it's fixed.

# Usage
```lua
-- just require and invoke it in your preferred mode
require('poopsmith')('janitor')

-- then declare some globals
a=420
people_that_arent_jackie_chan = {
	"the guy from cheers",
	"Kelsey Grammer",
	"Edgar Allan Poe"
}
ten_things_that_arent_jackie_chan = {
	"toothpaste",
	"pizza",
	"lamps",
	"jackie ch--"
}

-- show off the globals
for k,v in pairs(_G["💩"]) do
	print(k,v)
end
```

# Modes
## bobSaget
Uses `_G["💩"]` to store the last variable's value, while simultaneously changing all global's contents to "💩".
```
a										💩
💩										420
people_that_arent_jackie_chan			💩
ten_things_that_arent_jackie_chan		💩
```
## janitor
Uses `_G["💩"]` as a container for all global variables with names preserved.
```
💩										table: 0x2c56aea0
💩.a										420
💩.people_that_arent_jackie_chan			table: 0x2c56af00
💩.ten_things_that_arent_jackie_chan		table: 0x2c53ea58
```
## tamagotchi
Uses `_G["💩"]` to determine how long the next variable name should be.
```
💩		4
💩💩		420
💩💩💩	table: 0x1ba0cba0
💩💩💩💩	table: 0x1ba0cc18
```
## beanCounter
Like Tamagotchi, uses `_G["💩"]` to change the variable name to the order it was declared, globally.
```
💩		3
💩1		420
💩2		table: 0x2437eb80
💩3		table: 0x2437ec10
```

# Advanced Usage
Here are some other uses of this:
```lua
local poopsmith = require('poopsmith')

-- easy unicode poop access 
print(poopsmith.unipoop) -- prints "💩"
-- this is the same, but it uses a character escaped string
print(poopsmith.safepoop) -- prints "💩"

-- keep tabs on variables in janitor mode
for k,v in pairs(_G[poopsmith.unipoop]) do
	print(k,v)
end

-- figure out how many globals you were responsible for in tamagotchi mode
print(_G[poopsmith.unipoop])

-- make your own mode
poopsmith.modes['nonsense'] = {
	__smithSetup = function() 
		print('buckle up')
	end,
	__newindex = print
}
poopsmith.setMode('nonsense')
a=3 -- prints "_G, 'a', 3"
```

# Why?
Because LuaJIT lets me use unicode variable references, this is the natural extension of that.

Despite that, this will work with non-LuaJIT environments.

Also because it's fun.