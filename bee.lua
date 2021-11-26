local Bug = require("bug")

local Bee = Bug:new()

function Bee:spawn()
	bugCollisionFilter = { categoryBits=2, maskBits=1 }
	self.shape = display.newRect(self.xPos, self.yPos, 64, 64)
	self.shape:setFillColor(0, 0, 1)
	physics.addBody(self.shape, "dynamic", {bounce = 0, filter=bugCollisionFilter})
	self.shape.pp = self
end

return Bee