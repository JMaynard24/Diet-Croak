-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn  
--10/26/21 - added composer to go immediately to menu

local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()
display.setStatusBar(display.HiddenStatusBar)

-- event handler function for options button
local function onOptionsButton(event)
	-- load the options_menu overlay scene
	if event.phase == "began" then
		composer.showOverlay("options", {effect="fade", time=500, isModal=true})
	end
end

local function onPlayButton(event)
	 -- go to the game screen
	if event.phase == "began" then
        composer.removeScene("game")
		composer.gotoScene("game")
	end
end


function scene:create( event )

	local sceneGroup = self.view
	local playButtonTextOptions = 
    {
        text ="Play",
        x = display.contentCenterX,
        y = display.contentCenterY+50,
        font = "Arial",
        fontSize = 72

    }

    -- set initial game difficulty
    composer.setVariable("difficultyVar", 50/100 * .4+.1)

    local background = display.newImage("lake.jpg", display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(background)

    -- create a play button to begin the game and move to the game screen
    local playButton = display.newImage("defaultbutton.png", display.contentCenterX, display.contentCenterY+50)
    playButton:scale(1, .7)
    playButton:addEventListener( "touch", onPlayButton )
    local playButtonText = display.newText(playButtonTextOptions)
    sceneGroup:insert(playButton)
    sceneGroup:insert(playButtonText)

    local optionsButtonTextOptions = 
    {
        text ="Options",
        x = display.contentCenterX,
        y = display.contentCenterY+250,
        font = "Arial",
        fontSize = 72

    }

    -- create an options button to bring up the options menu
    local optionsButton = display.newImage("defaultbutton.png", display.contentCenterX, display.contentCenterY+250)
    optionsButton:scale(1, .7)
    optionsButton:addEventListener( "touch", onOptionsButton )
    local optionsButtonText = display.newText(optionsButtonTextOptions)
    sceneGroup:insert(optionsButton)
    sceneGroup:insert(optionsButtonText)

end
 
-- "scene:show()"
function scene:show( event )
 
	local sceneGroup = self.view
	local phase = event.phase
 
	if ( phase == "will" ) then
		print("menu scene")

		local sceneGroup = self.view

		-- create a label for the game title
		local titleLabel = display.newImage("CroakTitle.png", display.contentCenterX, display.contentCenterY-250)
        titleLabel:scale(.47,.5)
		sceneGroup:insert(titleLabel)

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