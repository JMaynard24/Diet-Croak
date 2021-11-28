local Bug = require("bug")

local Bee = Bug:new()

bee_opt = {frames = {{x=1, y=1, width = 264, height = 224}}}
bee_sequenceData = {{name = "idle", frames = {1}, time = 1000, loopCount = 1}}
bee_sheet = graphics.newImageSheet("bee.png", bee_opt);
beesheet = bee_sheet;
beesequenceData = bee_sequenceData;

function Bee:spawn()
	bugCollisionFilter = { categoryBits=2, maskBits=1 }
	self.shape = display.newSprite(beesheet, beesequenceData)
	self.shape.x = self.xPos
	self.shape.y = self.yPos
	self.shape.tag = "bee"
	self.shape.width=64
	self.shape.height=64
	physics.addBody(self.shape, "dynamic", {bounce = 0, filter=bugCollisionFilter})
	self.shape.pp = self
end

return Bee