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
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

      -- display game over message
      local screenLabel = display.newText("Game Over", display.contentCenterX, display.contentCenterY - 200, "Arial", 40)
      sceneGroup:insert(screenLabel)

      -- display score
      local scoreLabel = display.newText("Score: ", display.contentCenterX, display.contentCenterY - 150, "Arial", 20)
      sceneGroup:insert(scoreLabel)

      -- event handler for retry button
      local function onRetryButton(event)

      	-- go to game screen
      	composer.gotoScene("game")

      end

      -- options for retry button
      local retryButtonOptions =
      {
      	x = display.contentCenterX,
      	y = display.contentCenterY + 175,
      	label = "Retry",
      	labelColor = {default = {1,1,1}, over = {1,1,1}},
      	font = "Arial",
      	fontSize = 60,
      	shape = "Rectangle",
      	width = 360,
      	height = 100,
      	fillColor = {default = {0,1,0}, over = {0,0,1}},
      	onEvent = onRetryButton,
      }

      -- create a button to retry the game
      local retryButton = widget.newButton(retryButtonOptions)
      retryButton:scale(.25,.25)
      sceneGroup:insert(retryButton)

      -- event handler for menu button
      local function onMenuButton(event)

      	-- go to menu screen
      	composer.gotoScene("menu")

      end

      -- options for menu button
      local menuButtonOptions =
      {
      	x = display.contentCenterX,
      	y = display.contentCenterY + 225,
      	label = "Main Menu",
      	labelColor = {default = {1,1,1}, over = {1,1,1}},
      	font = "Arial",
      	fontSize = 60,
      	shape = "Rectangle",
      	width = 360,
      	height = 100,
      	fillColor = {default = {0,0,1}, over = {0,1,0}},
      	onEvent = onMenuButton,
      }

      -- create a button to return to the main menu
      local menuButton = widget.newButton(menuButtonOptions)
      menuButton:scale( .25, .25 )
      sceneGroup:insert(menuButton)


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