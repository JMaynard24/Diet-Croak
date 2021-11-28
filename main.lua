-- Matt Goodwin, Sam Martin, Patrick Berzins, Jeremiah Maynard, Benny Stellhorn
--10/26/21 - added composer to go immediately to menu


local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

soundtable = 
{
	runningWater = audio.loadSound("stream1.ogg"),
	backgroundMusic = audio.loadSound("forest.mp3"),
}

audio.setVolume( 0.4, { channel=1 } )
local options =
{
	channel = 1,
	loops = -1,
	fadein = 2000,
}
audio.play(soundtable["runningWater"], options)

audio.setVolume( 0.75, { channel=2 } )
local options =
{
	channel = 2,
	loops = -1,
	fadein = 2000,
}
audio.play(soundtable["backgroundMusic"], options)

composer.gotoScene("menu")