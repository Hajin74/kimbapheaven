-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- widget 라이브러리 추가
local widget = require("widget")

-- GUI 구성 요소 선언
local background
local movebtnUI
local materialUI = {}

function scene:create( event )
	local sceneGroup = self.view
    
    background = display.newImageRect("image/kitchen.png", display.contentWidth, display.contentHeight)
    background.x, background.y = display.contentWidth/2, display.contentHeight/2

    -- 김밥 재료 나열
    materialUI[1] = display.newImageRect("image/kim.png", 100, 100)
    materialUI[1].x, materialUI[1].y = 100, 100

    materialUI[2] = display.newImageRect("image/rice.png", 100, 100)
    materialUI[2].x, materialUI[2].y = 300, 100

    materialUI[3] = display.newImageRect("image/radish.png", 100, 100)
    materialUI[3].x, materialUI[3].y = 500, 100

    materialUI[4] = display.newImageRect("image/egg.png", 100, 100)
    materialUI[4].x, materialUI[4].y = 700, 100

    materialUI[5] = display.newImageRect("image/ham.png", 100, 100)
    materialUI[5].x, materialUI[5].y = 900, 100



    -- 함수
    local function moveEvent()
        composer.gotoScene( "counter" )
    end

    -- 이동 버튼
    movebtnUI = widget.newButton({
        defaultFile = "image/movecounterbtn.png", overFile = "image/movecounterbtn.png",
        width = 50, height = 100, onPress = moveEvent
    })
    movebtnUI.x, movebtnUI.y = 50, display.contentHeight/2

    

    -- 삽입
    sceneGroup:insert(background)
    sceneGroup:insert(movebtnUI)
    for i = 1, 5, 1 do
        sceneGroup:insert(materialUI[i])
    end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
