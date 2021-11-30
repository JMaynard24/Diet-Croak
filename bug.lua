local physics = require("physics")

local Bug = {name="Bug", xPos=0, yPos=0}

bug_opt = 	{frames = {
	{	x=2, y=3, width = 264, height = 224},
	{	x=2, y=228, width =264, height = 224}}
	}
bug_sequenceData = {{name = "idle", frames = {1, 2}, time = 200, loopCount = 0}}
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
	self.shape:setSequence( "idle" )
	self.shape:play()
	self.shape.x = self.xPos
	self.shape.y = self.yPos
	self.shape.tag = "bug"
	self.shape.width=64
	self.shape.height=56
	physics.addBody(self.shape, "dynamic", {bounce = 0, filter=bugCollisionFilter})
	self.shape:scale(0.25, 0.25)
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
	if self.shape ~= nil then
		self.shape:removeSelf()
	end
	self = nil
end

function Bug:flip()
	self.shape.xScale = -.25
	self.shape.yScale = .25
end

function del(obj)
	obj.pp:delete()
end
	

return Bug