-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn 

local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view
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
   
end
 
-- "scene:show()"
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase
	
	function screenTouched(event)
		if (event.phase == "began" and allowTongue) then
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
			tongue:setSequence("tongue")
			sceneGroup:insert(tongue)
			event_yDifference = tongue.y-event.y
			scaleMax = event_yDifference / 416
			transition.scaleTo(tongue, {xScale=.4, yScale=scaleMax, transition=linear, time=500*scaleMax})
		elseif (event.phase == "ended" and tongueExist) then
			print("event")
			transition.cancel(tongue)
			anim:setSequence("idle")
			transition.scaleTo(tongue, {xScale=.6, yScale=.01, transition=linear, time=500*scaleMax, onComplete= stopTongue})
			tongueExist = false
		end
	end
	
	function stopTongue()
		allowTongue = true
	end
 
	if ( phase == "will" ) then
		local waterfall = display.newImage("waterfall.png", display.contentCenterX, display.contentCenterY)
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
		allowTongue = true
		tongueExist = false
		waterfall:addEventListener("touch", screenTouched)

		-- label the screen (this will be removed)
		local screenLabel = display.newText("Game Screen", display.contentCenterX, display.contentCenterY, "Arial", 40)
		sceneGroup:insert(screenLabel)

		-- function to be executed upon the player emptying the hunger bar and dying
		local function onDeath(event)
			-- go to the game over screen
			composer.gotoScene("game_over")
		end 

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

		-- event handler function for options button
		local function onOptionsButton(event)

			-- load options_game overlay scene
			composer.showOverlay("options_game", {effect="fade", time=500, isModal=true})

		end

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
	elseif ( phase == "did" ) then
		  -- Called when the scene is now on screen.
		  -- Insert code here to make the scene come alive.
		  -- Example: start timers, begin animation, play audio, etc.
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