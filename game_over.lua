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

-- open leaderboard csv file
leaderboardFile = system.pathForFile("leaderboard.csv")

-- event handler for retry button
function onRetryButton(event)

   -- go to game screen
   if event.phase == "began" then
      composer.gotoScene("game")
   end

end

-- event handler for menu button
function onMenuButton(event)

   -- go to menu screen
   if event.phase == "began" then
      composer.gotoScene("menu")
   end

end
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.

   -- create table for leaderboard
      leaderboardTable = {}

      -- open the leaderboard file
      file = io.open(leaderboardFile, "r")

      -- populate table with top ten scores
      for line in file:lines() do
         table.insert(leaderboardTable, line)
      end

      -- close the leaderboard file
      io.close(file)
      file = nil

   -- display game over message
      print("game over scene")
      screenLabel = display.newText("Game Over", display.contentCenterX, display.contentCenterY - 350, "Arial", 60)
      sceneGroup:insert(screenLabel)

      -- display top ten leaderboard on screen with display text objects
      leaderboardLabel = display.newText("Top Ten Scores", display.contentCenterX, display.contentCenterY - 160, "Arial", 37)
      sceneGroup:insert(leaderboardLabel)

      -- display score
      scoreLabel = display.newText("Score: ", display.contentCenterX, display.contentCenterY - 285, "Arial", 30)
      sceneGroup:insert(scoreLabel)

      -- create text labels for each of the ten leaderboard slots
      scoreOne = display.newText("1: " .. leaderboardTable[1], display.contentCenterX, display.contentCenterY - 115, "Arial", 30)
      sceneGroup:insert(scoreOne)
      scoreTwo = display.newText("2: " .. leaderboardTable[2], display.contentCenterX, display.contentCenterY - 80, "Arial", 30)
      sceneGroup:insert(scoreTwo)
      scoreThree = display.newText("3: " .. leaderboardTable[3], display.contentCenterX, display.contentCenterY - 45, "Arial", 30)
      sceneGroup:insert(scoreThree)
      scoreFour = display.newText("4: " .. leaderboardTable[4], display.contentCenterX, display.contentCenterY - 10, "Arial", 30)
      sceneGroup:insert(scoreFour)
      scoreFive = display.newText("5: " .. leaderboardTable[5], display.contentCenterX, display.contentCenterY + 25, "Arial", 30)
      sceneGroup:insert(scoreFive)
      scoreSix = display.newText("6: " .. leaderboardTable[6], display.contentCenterX, display.contentCenterY + 60, "Arial", 30)
      sceneGroup:insert(scoreSix)
      scoreSeven = display.newText("7: " .. leaderboardTable[7], display.contentCenterX, display.contentCenterY + 95, "Arial", 30)
      sceneGroup:insert(scoreSeven)
      scoreEight = display.newText("8: " .. leaderboardTable[8], display.contentCenterX, display.contentCenterY + 130, "Arial", 30)
      sceneGroup:insert(scoreEight)
      scoreNine = display.newText("9: " .. leaderboardTable[9], display.contentCenterX, display.contentCenterY + 165, "Arial", 30)
      sceneGroup:insert(scoreNine)
      scoreTen = display.newText("10: " .. leaderboardTable[10], display.contentCenterX, display.contentCenterY + 200, "Arial", 30)
      sceneGroup:insert(scoreTen)

      -- options for retry button
      local retryButtonOptions =
      {
         x = display.contentCenterX,
         y = display.contentCenterY + 300,
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
      retryButton = widget.newButton(retryButtonOptions)
      retryButton:scale(.6,.6)
      sceneGroup:insert(retryButton)

      -- options for menu button
      local menuButtonOptions =
      {
         x = display.contentCenterX,
         y = display.contentCenterY + 375,
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
      menuButton = widget.newButton(menuButtonOptions)
      menuButton:scale( .6, .6 )
      sceneGroup:insert(menuButton)

end

-- function to add a score to the leaderboard if it is top ten
function addScore(score)
   leaderboardTable[11] = score
   for i=11, 1, -1 do
      for j=i-1, 1, -1 do
         if(tonumber(leaderboardTable[i]) > tonumber(leaderboardTable[j])) then
            local temp = leaderboardTable[i]
            leaderboardTable[i] = leaderboardTable[j]
            leaderboardTable[j] = temp
         end
      end
   end
   leaderboardTable[11] = nil
end

-- event handler for score button
function updateScores()

   -- add new score to the leaderboard (if it is top ten)
   --local newScore = params.score
   local newScore = 50
   addScore(newScore)
            
   -- update the leaderboard on the screen with the current top scores
   scoreOne.text = "1: " .. leaderboardTable[1]
   scoreTwo.text = "2: " .. leaderboardTable[2]
   scoreThree.text = "3: " .. leaderboardTable[3]
   scoreFour.text = "4: " .. leaderboardTable[4]
   scoreFive.text = "5: " .. leaderboardTable[5]
   scoreSix.text = "6: " .. leaderboardTable[6]
   scoreSeven.text = "7: " .. leaderboardTable[7]
   scoreEight.text = "8: " .. leaderboardTable[8]
   scoreNine.text = "9: " .. leaderboardTable[9]
   scoreTen.text = "10: " .. leaderboardTable[10]

   scoreLabel.text = "Score: " .. newScore

   -- update the csv file with the current top scores
   local file = io.open(leaderboardFile, "w")
   for i=1, 10, 1 do
      file:write(leaderboardTable[i] .. "\n")
   end
   io.close(file)
   file = nil

   print("leaderboard.csv file written")
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

      --local params = event.params

      updateScores()


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