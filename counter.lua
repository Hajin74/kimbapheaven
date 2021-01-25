-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 랜덤함수 초기화
math.randomseed(os.time())

-- widget 라이브러리 추가
local widget = require("widget")

-- GUI 구성 요소 선언
local background = {}
local hpUI = {}
local mentalityUI = {}
local timeUI = {}
local gameUI = {} -- 달력, 환경설정, 돈
local personUI = {}
local kimbapUI = {}
local orderbtnUI = {} -- 주문 수락
local movebtnUI -- 주방으로 이동

function scene:create( event )
    local sceneGroup = self.view
    
    -- 1-1) 배경: 트럭
    background[0] = display.newImageRect("image/foodtruck.png", display.contentWidth, 200)
    background[0].x, background[0].y = display.contentWidth/2, display.contentHeight - 100

    -- 1-2) 베경: 초등학교
    background[1] = display.newImageRect("image/school1.jpg", display.contentWidth, display.contentHeight)
    background[1].x, background[1].y = display.contentWidth/2, display.contentHeight/2

    -- 2-1) hp 체력: 10개로 쪼개기
    hpUI[0] = graphics.newImageSheet("image/hp.png", {width = 30, height = 30, numFrames = 10})
    
    -- hp[1~10]까지 hp쪼개서 넣기
    for i = 1, 10, 1 do
        hpUI[i] = display.newImageRect(hpUI[0], i, 30, 30)
    end

    -- hp위치 설정
    for i = 1, 10, 1 do
        hpUI[i].x, hpUI[i].y = 70 + (30 * i), 30
    end

    -- 2-2) mentality 정신력: 10개로 쪼개기
    mentalityUI[0] = graphics.newImageSheet("image/mentality.png", {width = 30, height = 30, numFrames = 10})
    
    -- mentality[1~10]까지 hp쪼개서 넣기
    for i = 1, 10, 1 do
        mentalityUI[i] = display.newImageRect(mentalityUI[0], i, 30, 30)
    end

    -- mentality위치 설정
    for i = 1, 10, 1 do
        mentalityUI[i].x, mentalityUI[i].y = 70 + (30 * i), 70
    end

    -- 3) 낮과 밤(시간)
    timeUI[1] = display.newImageRect("image/day.png", 75, 75)
    timeUI[1].x, timeUI[1].y = 50, 50

    timeUI[2] = display.newImageRect("image/night.png", 75, 75)
    timeUI[2].x, timeUI[2].y = 50, 50
    timeUI[2].alpha = 0

    -- 4) 달력
    gameUI[0] = display.newImageRect("image/calendar.png", 350, 200)
    gameUI[0].x, gameUI[0].y = display.contentWidth - 50, 50
    
    -- 4) 달력 글씨
    gameUI[1] = display.newText({
        text = "  0\n일째", x = display.contentWidth + 20 , y = 57, width = 200,
        font = "돋움", fontSize = 30
    })
    gameUI[1]:setFillColor(0)

    -- 4) 돈
    gameUI[2] = display.newImageRect("image/money.png", 200, 60)
    gameUI[2].x, gameUI[2].y = 120, display.contentHeight - 50

    gameUI[3] = display.newText({
        text = "  0000", x = 150 , y = display.contentHeight - 50, width = 200,
        font = "돋움", fontSize = 30
    })
    gameUI[3]:setFillColor(0)


    -- 5) 사람1
    personUI[1] = display.newImageRect("image/person1.png", 200, 400)
    personUI[1].x, personUI[1].y = display.contentWidth/2 - 200, display.contentHeight/2 - 50

    personUI[2] = display.newImageRect("image/person2.png", 200, 400)
    personUI[2].x, personUI[2].y = display.contentWidth/2 - 200, display.contentHeight/2 - 50
    personUI[2].alpha = 0

    personUI[3] = display.newImageRect("image/person3.png", 200, 400)
    personUI[3].x, personUI[3].y = display.contentWidth/2 - 200, display.contentHeight/2 - 50
    personUI[3].alpha = 0

    -- 6-1) 꼬마김밥
    kimbapUI[1] = display.newImageRect("image/kimbap_child.png", 400, 100)
    kimbapUI[1].x, kimbapUI[1].y = display.contentWidth/2 + 170, display.contentHeight/3


    -- 7-1) 함수
    local function orderEvent()
        composer.gotoScene( "cook" )
    end

    local function moveEvent()
        composer.gotoScene( "cook" )
    end
    

    -- 8) 버튼들
    -- 주문 수락 버튼
    orderbtnUI[1] = widget.newButton({
        defaultFile = "image/acceptbtn.png", overFile = "image/acceptbtn_over.png",
        width = 150, height = 50, onPress = orderEvent
    })
    orderbtnUI[1].x, orderbtnUI[1].y = display.contentWidth/2 + 50, display.contentHeight/2

    -- 주문 거절 버튼
    orderbtnUI[2] = widget.newButton({
        defaultFile = "image/rejectbtn.png", overFile = "image/rejectbtn_over.png",
        width = 150, height = 50, onPress = inputEvent
    })
    orderbtnUI[2].x, orderbtnUI[2].y = display.contentWidth/2 + 50, display.contentHeight/2 + 60

    -- 부엌으로 이동 버튼
    movebtnUI = widget.newButton({
        defaultFile = "image/movekitchenbtn.png", overFile = "image/movekitchenbtn.png",
        width = 50, height = 100, onPress = moveEvent
    })
    movebtnUI.x, movebtnUI.y = display.contentWidth - 50, display.contentHeight/2


    sceneGroup:insert(background[1]) -- 초등학교
    sceneGroup:insert(background[0]) -- 트럭
    for i = 1, 10, 1 do sceneGroup:insert(hpUI[i]) end
    for i = 1, 10, 1 do sceneGroup:insert(mentalityUI[i]) end
    for i = 1, 3, 1 do sceneGroup:insert(personUI[i]) end
    for i = 0, 3, 1 do sceneGroup:insert(gameUI[i]) end
    for i = 1, 2, 1 do 
        sceneGroup:insert(orderbtnUI[i]) 
        sceneGroup:insert(timeUI[i])
    end
    sceneGroup:insert(movebtnUI)
    sceneGroup:insert(kimbapUI[1])
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