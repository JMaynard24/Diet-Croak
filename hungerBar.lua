-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


--red bar 
--yellow bar over the red one

--update makes the width of the yellow bar shorter
--eatFly should add width based on the flyNum passed in

--all of these values are subject to change based on what we want the final product to look like
local gameOver = false
local initialLength = 150
local barLength = initialLength
local flyNum = 1
local flyHungerVal = 30
local difficulty = .5
local toungeOut = false

local height = 20
local x=75
local y=920
local width = barLength

redRect = display.newRect(x, y, width, height )
yellowRect= display.newRect(x, y, width-5, height-5 )

yellowRect:setFillColor( 1, 1, 0)
redRect:setFillColor( 1, 0, 0 )

local function eatFly()
	if(barLength >=initialLength-flyHungerVal*flyNum) then
		barLength = initialLength
	else
		barLength = barLength + flyNum*flyHungerVal
	end
	print(flyNum)

end

--[[
	collision handler for tounge just has to keep track of how many flies are on it 
	if you colide with a bee set flyNum to zero
	on touch release you can call eatFly or whenever the tounge gets back to the frog
	could have a global bool to tell when toungue is back to the frog and only call eatfly 
	when that is true
]]


local function update( ... )
	if(gameOver == false) then
		--print(barLength)
		if(barLength <= 0) then
			gameOver = true
			yellowRect.isVisible = false
			--flyNum = flyNum + 1
			--eatFly()

		else
			if(toungeOut) then
				tempDifficulty = difficulty + .1
			else
				tempDifficulty = difficulty
				--eatFly()
			end
			barLength = barLength - tempDifficulty
			width = barLength
			yellowRect:removeSelf()
			yellowRect = nil
			yellowRect= display.newRect(x+barLength/2 - initialLength/2, y, width-5, height-5 )
			yellowRect:setFillColor( 1, 1, 0)

		end
	end
end

timer.performWithDelay(10, update, 0 )