-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn 

local widget = require("widget")
local composer = require( "composer" )
local physics = require( "physics" )
local Bug = require("bug")
local Bee = require("bee")
local scene = composer.newScene()
physics.start()
physics.setGravity(0, 0)
physics.setDrawMode("hybrid")
sceneGroup = nil
timer1 = nil
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------

function spawnBug(event)
	side = math.random(1,2)
	row = math.random(1,5)
	target = math.random(1,5)
	speed = (math.random(10, 25) / 10) * 1000
	x = 0
	y = 0
	pos = {0, 0}
	if side == 1 then
		x = spawnPoints[1][row][1]
		y = spawnPoints[1][row][2]
		pos[1] = spawnPoints[2][target][1]
		pos[2] = spawnPoints[2][target][2]
	else
		x = spawnPoints[2][row][1]
		y = spawnPoints[2][row][2]
		pos[1] = spawnPoints[1][target][1]
		pos[2] = spawnPoints[1][target][2]
	end
	bugorbee = math.random(1, 2)
	if bugorbee == 1 then
		bug = Bee:new({xPos=x, yPos=y})
	else
		bug = Bug:new({xPos=x, yPos=y})
	end
	bug:spawn()
	bug:goTo(pos[1], pos[2], speed)
	sceneGroup:insert(bug.shape)
	timer1 = timer.performWithDelay(bugSpawnTimer, spawnBug)
end

function screenTouched(event)
	if (event.phase == "began" and allowTongue and event.y < 600) then
		tongueExist = true
		anim:setSequence("shoot")
		allowTongue = false
		--anim:play()
		tongue = display.newSprite(frog_sheet, sequenceData);
		tongue.anchorX = .5;
		tongue.anchorY= 1;
		tongue:scale(0.6, .06)
		tongue.x = display.contentCenterX;
		tongue.y = 864;
		event_xDifference = event.x - display.contentCenterX
		event_yDifference = tongue.y-event.y
		scaleMaxSquared = event_xDifference^2 + event_yDifference^2
		scaleMaxSqrt = math.sqrt(scaleMaxSquared)
		scaleMax = scaleMaxSqrt / 416
		rotationTongue = math.sin(event_xDifference/event_yDifference)
		tongue:rotate(rotationTongue*57.298)
		tongue:setSequence("tongue")
		tongueHitbox:rotate(rotationTongue*57.298)
		transition.scaleTo(tongue, {xScale=.4, yScale=scaleMax, transition=linear, time=400*scaleMax})
		transition.to(tongueHitbox, {x=event.x, y=event.y, time=400*scaleMax})
	elseif (event.phase == "ended" and tongueExist) then
		print("event")
		transition.cancel(tongue)
		transition.cancel(tongueHitbox)
		transition.scaleTo(tongue, {xScale=.6, yScale=.01, transition=linear, time=300*scaleMax, onComplete= stopTongue})
		transition.to(tongueHitbox, {x=tongue.x, y=tongue.y, time=300*scaleMax})
		tongueExist = false
	end
end

-- function to be executed upon the player emptying the hunger bar and dying
local function onDeath(event)
	-- go to the game over screen
	if event.phase == "began" then
		composer.gotoScene("game_over")
	end
end

-- event handler function for options button
local function onOptionsButton(event)

	-- load options_game overlay scene
	if event.phase == "began" then
		composer.showOverlay("options_game", {effect="fade", time=500, isModal=true})
	end

end

function stopTongue()
	allowTongue = true
	tongue:removeSelf( )
	anim:setSequence("idle")
	tongueHitbox:rotate(-(rotationTongue*57.298))
end


-- "scene:create()"
function scene:create( event )

	sceneGroup = self.view
	frog_opt = {
					frames = {
							{x=1, y=1, width = 320, height = 304},
							{x=1, y= 307, width =320, height = 304},
							{x=323, y= 1, width = 80, height = 416}
					}
				}

	frog_sequenceData = {
						{name = "idle", frames = {1}, time = 1000, loopCount = 1},
						{name = "shoot", frames = {2}, time =1000, loopCount = 1},
						{name = "tongue", frames = {3}, time =1000, loopCount = 1}
						}

	frog_sheet = graphics.newImageSheet("Spritesheet1.png", frog_opt);
	sheet = frog_sheet;
	sequenceData = frog_sequenceData;
	
	spawnPoints = { {{-100, 110}, {-100, 210}, {-100, 310}, {-100, 410}, {-100, 510}},
					{{640, 110}, {640, 210}, {640, 310}, {640, 410}, {640, 510}}}
	
	local waterfall = display.newImage("waterfall.png", display.contentCenterX, display.contentCenterY)
	sceneGroup:insert(waterfall)
	-- Called when the scene is still off screen (but is about to come on screen).
	anim = display.newSprite(frog_sheet, sequenceData);
	anim.anchorX = .5;
	anim.anchorY= 1;
	anim.x = display.contentCenterX;
	anim.y = 960;
	anim:scale(0.6, 0.6)
	anim:setSequence("idle")
	sceneGroup:insert(anim)
	waterfall:toBack()
	waterfall:addEventListener("touch", screenTouched)
	
	tongueHitbox = display.newRect(display.contentCenterX, 864, 40, 1000)
	tongueHitbox.isVisible = false
	tongueHitbox.anchorX = .5
	tongueHitbox.anchorY = 0
	physics.addBody(tongueHitbox, "dynamic", {isSensor=true})
	
	-- label the screen (this will be removed)
	local screenLabel = display.newText("Game Screen", display.contentCenterX, display.contentCenterY, "Arial", 40)
	sceneGroup:insert(screenLabel)
	
		-- create options for die button (this will be removed)
	local dieButtonOptions =
	{
		x = display.contentCenterX,
		y = display.contentCenterY + 50,
		label = "Die",
		font = "Arial",
		fontSize = 25,
		textOnly = true,
		labelColor = {default = {1,0,0}, over = {0,0,1}},
		onEvent = onDeath,
	}

	-- add a button to simulate dying and game over (this will be removed)
	local dieButton = widget.newButton(dieButtonOptions)
	sceneGroup:insert(dieButton)
	
		-- options for the options button
	local optionsButtonOptions =
	{
		x = display.contentWidth - 100,
		y = 50,
		label = "Options",
		font = "Arial",
		fontSize = 50,
		labelColor = {default = {1,1,1}, over = {1,1,1}},
		shape = "Rectangle",
		width = 360,
		height = 100,
		fillColor = {default = {0,0,1}, over = {0,1,0}},
		onEvent = onOptionsButton,
	}

	-- add an options button to load options overlay menu
	local optionsButton = widget.newButton(optionsButtonOptions)
	optionsButton:scale(.5,.5)
	sceneGroup:insert(optionsButton)
   
end

-- "scene:show()"
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	bugSpawnTimer = 1000
	
	if ( phase == "will" ) then
		print("game scene")
		allowTongue = true
		tongueExist = false
	elseif ( phase == "did" ) then
		timer1 = timer.performWithDelay(bugSpawnTimer, spawnBug)
	end
end
 
-- "scene:hide()"
function scene:hide( event )
 
	local sceneGroup = self.view
	local phase = event.phase
	 
	if ( phase == "will" ) then
		-- Called when the scene is on screen (but is about to go off screen).
		-- Insert code here to "pause" the scene.
		-- Example: stop timers, stop animation, stop audio, etc.
	elseif ( phase == "did" ) then
		--composer.removeScene("game")
		-- Called immediately after scene goes off screen.
	end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
	local sceneGroup = self.view
 
	-- Called prior to the removal of scene's view ("sceneGroup").
	-- Insert code here to clean up the scene.
	-- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------
 
return scene