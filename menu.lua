-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn  
--10/26/21 - added composer to go immediately to menu

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()
display.setStatusBar(display.HiddenStatusBar)



function scene:create( event )
	-- options for play button
    local playButtonOptions = 
    {
        x = display.contentCenterX,
        y = display.contentCenterY,
        label = "Play",
        labelColor = {default = {1,1,1}, over = {1,1,1}},
        font = "Arial",
        fontSize = 60,
        shape = "Rectangle",
        width = 360,
        height = 100,
        fillColor = {default = {0,1,0}, over = {0,0,1}},
        onEvent = onPlayButton,
    }

    -- create a play button to begin the game and move to the game screen
    local playButton = widget.newButton(playButtonOptions)
    sceneGroup:insert(playButton)

    -- event handler function for options button
    local function onOptionsButton(event)
        -- load the options_menu overlay scene
		if event.phase == "began" then
			composer.showOverlay("options_main", {effect="fade", time=500, isModal=true})
		end
    end

    -- options for options button
    local optionsButtonOptions =
    {
        x = display.contentCenterX,
        y = display.contentCenterY + 150,
        label = "Options",
        labelColor = {default = {1,1,1}, over = {1,1,1}},
        font = "Arial",
        fontSize = 60,
        shape = "Rectangle",
        width = 360,
        height = 100,
        fillColor = {default = {0,0,1}, over = {0,1,0}},
        onEvent = onOptionsButton,
    }

    -- create an options button to bring up the options menu
    local optionsButton = widget.newButton(optionsButtonOptions)
    sceneGroup:insert(optionsButton)
end
 
-- "scene:show()"
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
		print("menu scene")
      

		local sceneGroup = self.view

		-- create a label for the game title
		local titleLabel = display.newText("Diet Croak", display.contentCenterX,display.contentCenterY - 350, "Arial", 80)
		sceneGroup:insert(titleLabel)

		-- event handler function for the play button
		local function onPlayButton(event)

         -- go to the game screen
		if event.phase == "began" then
			composer.gotoScene("game")
		end

    elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
    end
end
 
-- "scene:hide()"
function scene:hide( event )
 
	local phase = event.phase
   

	if ( phase == "will" ) then
		-- Called when the scene is on screen (but is about to go off screen).
		-- Insert code here to "pause" the scene.
		-- Example: stop timers, stop animation, stop audio, etc.
	elseif ( phase == "did" ) then
		local sceneGroup = self.view
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