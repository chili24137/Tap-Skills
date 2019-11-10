--Main.lua
--Tap Skills
--Chris Childers
--chili24137@gmail.com

local background=display.setDefault("background", 1, 1, 1)

local hiScore=0
local currentScore=0

function saveScore()
  local saved=system.setPreferences("app",{currentScore=hiScore} )
  if(saved==false)
  then
      print("error: can't save score")
  end

end

function loadScore()
local loadedScore=system.getPreference("app", "currentScore", "number" )

if(loadedScore) then
  hiScore=loadedScore
else
  print("error: can't load score")
end

end

loadScore()

local gameHappening=false
--local title=display.newText("Tap Skills", display.contentCenterX, 200, native.systemFont, 200)
local LogoPng=display.newImageRect("TapSkillsLogo.png", 1000, 288)
LogoPng.x=display.contentCenterX
LogoPng.y=display.contentCenterY-780

local PondScumPng=display.newImageRect("TapSkillsPondScum.png", 800, 500)
PondScumPng.x=display.contentCenterX-80
PondScumPng.y=display.contentCenterY-370
PondScumPng.isVisible=false
local NoobPng=display.newImageRect("TapSkillsNoob.png", 650, 500)
NoobPng.x=display.contentCenterX
NoobPng.y=display.contentCenterY-370
NoobPng.isVisible=false
local StillBadPng=display.newImageRect("TapSkillsStillBad.png", 800, 500)
StillBadPng.x=display.contentCenterX
StillBadPng.y=display.contentCenterY-370
StillBadPng.isVisible=false
local SubparPng=display.newImageRect("TapSkillsSubpar.png", 800, 500)
SubparPng.x=display.contentCenterX-100
SubparPng.y=display.contentCenterY-370
SubparPng.isVisible=false
local AveragePng=display.newImageRect("TapSkillsAverage.png", 800, 500)
AveragePng.x=display.contentCenterX
AveragePng.y=display.contentCenterY-370
AveragePng.isVisible=false
local CoordinatedPng=display.newImageRect("TapSkillsCoordinated.png", 800, 500)
CoordinatedPng.x=display.contentCenterX
CoordinatedPng.y=display.contentCenterY-370
CoordinatedPng.isVisible=false
local WizardPng=display.newImageRect("TapSkillsWizard.png", 800, 500)
WizardPng.x=display.contentCenterX-70
WizardPng.y=display.contentCenterY-370
WizardPng.isVisible=false
local GodPng=display.newImageRect("TapSkillsGod.png", 800, 500)
GodPng.x=display.contentCenterX-100
GodPng.y=display.contentCenterY-365
GodPng.isVisible=false

local hiScoreText=display.newText("Hiscore:" .. hiScore, display.contentCenterX-260, 900, native.systemFont, 60)
local youAreText=display.newText("You are something ", display.contentCenterX+230, 900, native.systemFont, 60)
youAreText:setFillColor(0,0,0)
local currentScoreText=display.newText("Current Score: " .. currentScore, display.contentCenterX, 975, native.systemFont, 50)
--local rulesButton=display.newText("Rules", display.contentCenterX, 800, native.systemFont, 80)
local playButton=display.newText("Play", display.contentCenterX, display.contentCenterY+700, native.systemFont, 180)
playButton:setFillColor(0,0,0)

local adButton=display.newImageRect("adButton.png", 150,150)
adButton.x=display.contentCenterX+250
adButton.y=display.contentCenterY+160
local considerText=display.newText("Consider watching ad\n      to support me ->", display.contentCenterX-95, display.contentCenterY+160, native.systemFont,50)
considerText:setFillColor(0,0,0)

local privacyPolicy=display.newText("Privacy Policy", 150, display.contentCenterY+920, native.systemFont, 45)
privacyPolicy:setFillColor(0,0,0)

local endTime=0
local currentTime=0
local timeThreshold=500

local applovin=require("plugin.applovin")

local function adListener(event)
  print("hello")
  if ( event.phase == "init" ) then  -- Successful initialization
          print( event.isError )
          -- Load an AppLovin ad
          applovin.load( "interstitial" )

      elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
          print( event.type )

      elseif ( event.phase == "failed" ) then  -- The ad failed to load
          print( event.type )
          print( event.isError )
          print( event.response )

      elseif ( event.phase == "displayed" or event.phase == "playbackBegan" ) then  -- The ad was displayed/played
          print( event.type )

      elseif ( event.phase == "hidden" or event.phase == "playbackEnded" ) then  -- The ad was closed/hidden
          print( event.type )

      elseif ( event.phase == "clicked" ) then  -- The ad was clicked/tapped
          print( event.type )
      end
end

applovin.init(adListener, {sdkKey="JDx7tCWxr76RNQprHLFSoiHibID8dUoTAeGFSt1dFRlvoalH3m5Qrbz-yOSctG2I4XAGaIaymKQu5TOi_TBZ3t"} )

local function runAd(event)
  currentTime=system.getTimer()
  if endTime+timeThreshold<currentTime then
  local isAdLoaded = applovin.isLoaded( "interstitial" )
  if ( isAdLoaded == true and gameHappening==false) then
    applovin.show( "interstitial" )
    applovin.load( "interstitial" )
end
end
end

local eventTimer
local whiteStart=0

hiScoreText:setFillColor(0,0,0)
currentScoreText:setFillColor(0,0,0)

local missedButtons=0
local other=.8
background=display.setDefault()

local circle=display.newCircle(0,0,150)
--circle:setFillColor(.81,.27,1)
circle:setFillColor(0,0,0)
circle.isVisible=false

local function updateRank()

PondScumPng.isVisible=false
NoobPng.isVisible=false
StillBadPng.isVisible=false
SubparPng.isVisible=false
AveragePng.isVisible=false
CoordinatedPng.isVisible=false
WizardPng.isVisible=false
GodPng.isVisible=false

if hiScore<10 then PondScumPng.isVisible=true
  youAreText.text="You are Pond Scum"
elseif hiScore<25 then NoobPng.isVisible=true
  youAreText.text="You suck noob"
elseif hiScore<50 then StillBadPng.isVisible=true
  youAreText.text="You are bad"
elseif hiScore<100 then SubparPng.isVisible=true
  youAreText.text="You are subpar"
elseif hiScore<250 then AveragePng.isVisible=true
  youAreText.text="You are average"
elseif hiScore<500 then CoordinatedPng.isVisible=true
  youAreText.text="You are coordinated"
elseif hiScore<1000 then WizardPng.isVisible=true
  youAreText.text="You're a wizard"
else
  GodPng.isVisible=true
youAreText.text="You are God"
end

end

updateRank()


local counter=0

local function addScore(event)
if(event.phase=="began") then
    counter=1
currentScore=currentScore+1
currentScoreText.text="Current Score: "..currentScore
display.remove(circle)
circle=display.newCircle(0,0,150)
circle:setFillColor(0,0,0)
circle.isVisible=false
if (playButton.isVisible==False) then print("hello") end
end
end

local function spawnCircle()
  randX=math.random(150,930)
  randY=math.random(1180,1770)
  circle.x=randX
  circle.y=randY
  circle.isVisible=true
  if counter==1 then circle:addEventListener("touch", addScore)
  else
  missedButtons=missedButtons+1
  if other-.16>0 then
  other=other-.16
  else
    other=0
  end
  if whiteStart == 0 then background=display.setDefault("background",1,1,1)
else
  background=display.setDefault("background",1-missedButtons*.04,other,other)
  end
  whiteStart=whiteStart+1

end
counter=2

  if missedButtons>10 then --game over if missed buttons=10
    considerText.isVisible=true
    adButton.isVisible=true
    privacyPolicy.isVisible=true
    endTime=system.getTimer()
    whiteStart=0
    other=.8
    background=display.setDefault("background",1,1,1)
    timer.cancel(eventTimer)
    circle.isVisible=false
    playButton.isVisible=true
    missedButtons=0
    if currentScore>hiScore then hiScore=currentScore
    end
    currentScore=0
    hiScoreText.text="Hiscore:" .. hiScore
    updateRank()
    saveScore()
    gameHappening=false
  end

end

local function gameLoop(event)
  gameHappening=true
  playButton.isVisible=false --hides play button
  considerText.isVisible=false
  adButton.isVisible=false
  privacyPolicy.isVisible=false
  eventTimer=timer.performWithDelay(350, spawnCircle, 0)

return true
end

local function openPrivacyPolicyUrl()
  currentTime=system.getTimer()
  if endTime+timeThreshold<currentTime then
system.openURL( "https://chrischildersdev.wordpress.com/2019/05/15/hey/" )
end

end


privacyPolicy:addEventListener("tap",openPrivacyPolicyUrl)
circle:addEventListener("touch", addScore)
playButton:addEventListener("tap", gameLoop)
adButton:addEventListener("tap", runAd)
