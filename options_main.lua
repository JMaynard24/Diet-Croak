-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn  
-- Overlay scene for the options screen accessed from the main menu

local composer = require("composer")
local widget = require("widget")
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
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

      -- create translucent rounded rectangle to use as background for the overlay scene
      local backgroundRect = display.newRoundedRect(display.contentCenterX, display.contentCenterY + 50,250,400,10)
      backgroundRect:setFillColor(0,1,0)
      sceneGroup:insert(backgroundRect)

      -- add a text label at the top of the options menu
      local optionsLabel = display.newText("Options", display.contentCenterX, display.contentCenterY - 125, "Arial", 30)
      optionsLabel:setFillColor(0,0,0)
      sceneGroup:insert(optionsLabel)

      -- options for difficulty slider
      local difficultySliderOptions =
      {
         x = display.contentCenterX,
         y = display.contentCenterY - 30,
         width = 200,
         value = 50,
      }

      -- create and label slider for game difficulty
      local difficultySliderEasy = display.newText("Easy", 75, display.contentCenterY - 45, "Arial", 12)
      difficultySliderEasy:setFillColor(0,0,0)
      sceneGroup:insert(difficultySliderEasy)
      local difficultySliderHard = display.newText("Hard", 245, display.contentCenterY - 45, "Arial", 12)
      difficultySliderHard:setFillColor( 0,0,0)
      sceneGroup:insert(difficultySliderHard)
      local difficultySlider = widget.newSlider(difficultySliderOptions)
      sceneGroup:insert(difficultySlider)
      local difficultySliderLabel = display.newText("Difficulty", display.contentCenterX, display.contentCenterY - 60, "Arial", 20)
      difficultySliderLabel:setFillColor(0,0,0)
      sceneGroup:insert(difficultySliderLabel)

      -- options for volume slider
      local volumeSliderOptions =
      {
         x = display.contentCenterX,
         y = display.contentCenterY + 30,
         width = 200,
         value = 100,
      }

      -- create and label slider for game volume
      local volumeSlider = widget.newSlider(volumeSliderOptions)
      sceneGroup:insert(volumeSlider)
      local volumeSliderLabel = display.newText("Volume", display.contentCenterX, display.contentCenterY, "Arial", 20)
      volumeSliderLabel:setFillColor(0,0,0)
      sceneGroup:insert(volumeSliderLabel)

      -- string for how to instructions for the game
      local howToInstructions = "Touch the screen to extend the frog's tounge, and release to retract it. Catch flies in the extended tounge, and avoid bees. If the hunger bar runs out it's game over, so keep the frog fed!"

      -- create text area with how-to instructions for the game
      local howToLabel = display.newText("How to Play", display.contentCenterX, display.contentCenterY + 60, "Arial", 20)
      howToLabel:setFillColor(0,0,0)
      sceneGroup:insert(howToLabel)
      local howToText = display.newText(howToInstructions, display.contentCenterX, display.contentCenterY + 130, 200, 100, "Arial", 12)
      howToText:setFillColor(0,0,0)
      sceneGroup:insert(howToText)

      -- event handler for the close button
      local function onCloseButton(event)

         -- hide the options_main overlay
         composer.hideOverlay("fade", 150)

      end

      -- options for close button
      local closeButtonOptions =
      {
         x = display.contentCenterX,
         y = display.contentCenterY + 210,
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
      closeButton:scale(.3,.3)
      sceneGroup:insert(closeButton)

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