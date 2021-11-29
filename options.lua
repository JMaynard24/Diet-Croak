-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn
-- Overlay scene for the options screen 

local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------

-- event handler for the close button
local function onCloseButton(event)
	-- hide the options_main overlay
	if event.phase == "began" then
		composer.hideOverlay("fade", 150)
	end
end

 
-- "scene:create()"
function scene:create( event )
 
	local sceneGroup = self.view
 
	-- Initialize the scene here.
	-- Example: add display objects to "sceneGroup", add touch listeners, etc.

	-- create rounded rectangle to use as background for the overlay scene
	local backgroundRect = display.newRoundedRect(display.contentCenterX, display.contentCenterY + 50,400,550,10)
	backgroundRect:setFillColor(0,1,0)
	sceneGroup:insert(backgroundRect)

	-- add a text label at the top of the options menu
	local optionsLabel = display.newText("Options", display.contentCenterX, display.contentCenterY - 175, "Arial", 50)
	optionsLabel:setFillColor(0,0,0)
	sceneGroup:insert(optionsLabel)

	

	-- string for how to instructions for the game
	local howToInstructions = "Touch the screen to extend the frog's tounge, and release to retract it. Catch flies in the extended tounge, and avoid bees. If the hunger bar runs out it's game over, so keep the frog fed!"

	-- create text area with how-to instructions for the game
	local howToLabel = display.newText("How to Play", display.contentCenterX, display.contentCenterY + 30, "Arial", 25)
	howToLabel:setFillColor(0,0,0)
	sceneGroup:insert(howToLabel)
	local howToText = display.newText(howToInstructions, display.contentCenterX, display.contentCenterY + 160, 300, 200, "Arial", 20)
	howToText:setFillColor(0,0,0)
	sceneGroup:insert(howToText)

	-- options for close button
	local closeButtonOptions =
	{
		x = display.contentCenterX,
		y = display.contentCenterY + 275,
		label = "Close",
		labelColor = {default = {1,1,1}, over = {1,1,1}},
		font = "Arial",
		fontSize = 60,
		shape = "Rectangle",
		width = 360,
		height = 100,
		fillColor = {default = {0,0,1}, over = {1,0,0}},
		onEvent = onCloseButton,
	}

	-- create button to close options menu
	local closeButton = widget.newButton(closeButtonOptions)
	closeButton:scale(.5,.5)
	sceneGroup:insert(closeButton)
	local sliderVal = 50;
	local function difficultySliderListener( event )
		sliderVal = event.value
		if sliderVal == 0 then
			sliderVal = 1
		end
		print( "transition time is" .. sliderVal/100 * .4+.1 .. "in ms" )
		composer.setVariable("difficultyVar", sliderVal/100 * .2+.1) 
	end
	-- options for difficulty slider
	local difficultySliderOptions =
	{
		x = display.contentCenterX,
		y = display.contentCenterY - 25,
		width = 300,
		value = 50,
		listener = difficultySliderListener
	}

	-- create and label slider for game difficulty
	local difficultySliderEasy = display.newText("Easy", 145, display.contentCenterY - 40, "Arial", 16)
	difficultySliderEasy:setFillColor(0,0,0)
	sceneGroup:insert(difficultySliderEasy)
	local difficultySliderHard = display.newText("Hard", 395, display.contentCenterY - 40, "Arial", 16)
	difficultySliderHard:setFillColor( 0,0,0)
	sceneGroup:insert(difficultySliderHard)
	local difficultySlider = widget.newSlider(difficultySliderOptions)
	sceneGroup:insert(difficultySlider)
	local difficultySliderLabel = display.newText("Difficulty", display.contentCenterX, display.contentCenterY - 50, "Arial", 25)
	difficultySliderLabel:setFillColor(0,0,0)
	sceneGroup:insert(difficultySliderLabel)


end
 
-- "scene:show()"
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
	-- Called when the scene is still off screen (but is about to come on screen).

	local parent = event.parent

	local function sliderTouchListener (event)
		if event.phase == "ended" then
			audio.setVolume((volumeSlider.value/100)*0.4, {channel=1} )
			audio.setVolume((volumeSlider.value/100)*0.75, {channel=2} )
			composer.setVariable("volumeValue", volumeSlider.value)
		end
	end

	-- options for volume slider
	local volumeSliderOptions =
	{
		x = display.contentCenterX,
		y = display.contentCenterY - 100,
		width = 300,
		value = (audio.getVolume({channel=1})/0.4)*100,
	}

	-- create and label slider for game volume
	volumeSlider = widget.newSlider(volumeSliderOptions)
	sceneGroup:insert(volumeSlider)
	volumeSliderLabel = display.newText("Volume", display.contentCenterX, display.contentCenterY - 125, "Arial", 25)
	volumeSliderLabel:setFillColor(0,0,0)
	volumeSlider:addEventListener( "touch", sliderTouchListener )
	composer.setVariable("volumeValue", volumeSlider.value)
	sceneGroup:insert(volumeSliderLabel)


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