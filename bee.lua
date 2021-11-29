local Bug = require("bug")

local Bee = Bug:new()

bee_opt = {frames = {
	{	x=1, y=3, width = 256, height = 152},
	{	x=1, y=201, width = 256, height = 152}}}
bee_sequenceData = {{name = "idle", frames = {1, 2}, time = 200, loopCount = 0}}
bee_sheet = graphics.newImageSheet("bee.png", bee_opt);
beesheet = bee_sheet;
beesequenceData = bee_sequenceData;

function Bee:spawn()
	bugCollisionFilter = { categoryBits=2, maskBits=1 }
	self.shape = display.newSprite(beesheet, beesequenceData)
	self.shape:setSequence( "idle" )
	self.shape:play()
	self.shape.x = self.xPos
	self.shape.y = self.yPos
	self.shape.tag = "bee"
	self.shape.width=66
	self.shape.height=38
	physics.addBody(self.shape, "dynamic", {bounce = 0, filter=bugCollisionFilter})
	self.shape:scale(0.25, 0.25)
	self.shape.pp = self
end

return Bee