local poopsmith = {
	_VERSION     = 'poopsmith 1.0.0',
	_DESCRIPTION = 'The much less useful alternative to strict.lua',
	_URL         = 'https://github.com/EntranceJew/poopsmith.lua',
	_LICENSE     = [[
		The MIT License (MIT)

		Copyright (c) 2015 EntranceJew

		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:

		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.

		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	]]
}

-- to share, with the lazy
poopsmith.unipoop = "💩"
poopsmith.safepoop = "\240\159\146\169"

-- all the valid modes
poopsmith.modes = {
	bobSaget = {
		__newindex = function(g, name, value)
			rawset(_G, poopsmith.unipoop, value)
			return rawset(_G, name, poopsmith.unipoop) 
		end
	},
	janitor = {
		__smithSetup = function()
			rawset(_G, poopsmith.unipoop, {})
		end,
		__newindex = function(g, name, value)
			return rawset(_G[poopsmith.unipoop], name, value) 
		end
	},
	tamagotchi = {
		__smithSetup = function()
			rawset(_G, poopsmith.unipoop, 1)
		end,
		__newindex = function(g, name, value)
			rawset(_G, poopsmith.unipoop, rawget(_G, poopsmith.unipoop)+1)
			return rawset(_G, poopsmith.unipoop:rep(_G[poopsmith.unipoop]), value)
		end
	},
	beanCounter = {
		__smithSetup = function()
			rawset(_G, poopsmith.unipoop, 0)
		end,
		__newindex = function(g, name, value)
			rawset(_G, poopsmith.unipoop, rawget(_G, poopsmith.unipoop)+1)
			return rawset(_G, poopsmith.unipoop .. _G[poopsmith.unipoop], value)
		end
	},
}

function poopsmith.setMode(mode)
	if not poopsmith.modes[mode] then
		return false
	end
	
	if poopsmith.modes[mode].__smithSetup then
		poopsmith.modes[mode].__smithSetup()
	end
	
	setmetatable(_G, poopsmith.modes[mode])
	return true
end

return setmetatable(poopsmith, {__call = function(_, mode) poopsmith.setMode(mode) end})