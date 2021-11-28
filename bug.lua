local physics = require("physics")

local Bug = {name="Bug", xPos=0, yPos=0}

bug_opt = 	{frames = {{x=1, y=1, width = 264, height = 224}}}
bug_sequenceData = {{name = "idle", frames = {1}, time = 1000, loopCount = 1}}
bug_sheet = graphics.newImageSheet("fly.png", bug_opt);
bugsheet = bug_sheet;
bugsequenceData = bug_sequenceData;

function Bug:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self;
	return o
end

function Bug:spawn()
	bugCollisionFilter = { categoryBits=2, maskBits=1 }
	self.shape = display.newSprite(bugsheet, bugsequenceData)
	self.shape.x = self.xPos
	self.shape.y = self.yPos
	self.shape.tag = "bug"
	self.shape.width = 64
	self.shape.height = 64
	--self.shape:setFillColor(1, 0, 0)
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

function Bug:flip()
	self.shape.xScale = -1
end

function del(obj)
	obj.pp:delete()
end
	

return Bug