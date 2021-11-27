local physics = require("physics")

local Bug = {name="Bug", xPos=0, yPos=0}

function Bug:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self;
	return o
end

function Bug:spawn()
	bugCollisionFilter = { categoryBits=2, maskBits=1 }
	self.shape = display.newRect(self.xPos, self.yPos, 64, 64)
	self.shape.tag = "bug"
	self.shape:setFillColor(1, 0, 0)
	physics.addBody(self.shape, "dynamic", {bounce = 0, filter=bugCollisionFilter})
	self.shape.isFixedRotation = true
	self.shape.pp = self
end

function Bug:goTo(destX, destY, t)
	opt =   {
			time = t,
			x = destX,
			y = destY,
			onComplete = del
			}
			
	transition.to(self.shape, opt)
end

function Bug:caught()
	transition.cancel(self.shape)
end

function Bug:delete()
	self.shape:removeSelf()
	self = nil
end

function del(obj)
	obj.pp:delete()
end
	

return Bug