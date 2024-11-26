local composer = require("composer")
local scene = composer.newScene()

local chromosomes = {} -- Store chromosome objects for easy access
local isShaken = false -- Tracks if the shaking has already triggered

-- Function to clean resources
local function cleanScene()
    isShaken = false -- Reset shake state
end

-- Move chromosomes to a vertically aligned column, lowering them on the Y-axis
local function moveChromosomesToVerticalAlignment()
    for i, chromosome in ipairs(chromosomes) do
        transition.to(chromosome, {
            time = 500,
            x = display.contentCenterX, -- Move to the center of the screen on the X-axis
            y = display.contentCenterY + 30 + (i - 1) * 40, -- Lower the column by starting at `display.contentCenterY + 50`
            rotation = 90, -- Rotate each chromosome upright
        })
    end
    print("Chromosomes aligned in a vertical column.")
end

-- Function to handle shaking and triggering chromosome alignment
local function onAccelerometer(event)
    if not isShaken and (math.abs(event.xInstant) > 1.1 or math.abs(event.yInstant) > 1.1 or math.abs(event.zInstant) > 1.1) then
        print("Shaking detected! Aligning chromosomes.")
        isShaken = true -- Prevent triggering again
        moveChromosomesToVerticalAlignment()
    end
end

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Metafase.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local metaphaseEmpty = display.newImageRect(sceneGroup, "imagens/metaphase/metaphase-empty.png", 145, 161)
    metaphaseEmpty.x = display.contentCenterX
    metaphaseEmpty.y = display.contentCenterY + 90

    -- Initialize chromosomes
    local chromosomePositions = {
        { x = display.contentCenterX - 25, y = display.contentCenterY + 80 },
        { x = display.contentCenterX + 25, y = display.contentCenterY + 110 },
        { x = display.contentCenterX - 15, y = display.contentCenterY + 60 },
        { x = display.contentCenterX + 35, y = display.contentCenterY + 120 }
    }

    for i, pos in ipairs(chromosomePositions) do
        local image = "imagens/metaphase/chromosome-" .. (i % 2 == 0 and "2" or "1") .. ".png"
        local chromosome = display.newImageRect(sceneGroup, image, 26, 14)
        chromosome.x = pos.x
        chromosome.y = pos.y
        table.insert(chromosomes, chromosome)
    end

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina5", { effect = "slideLeft", time = 500 })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina3", { effect = "slideRight", time = 500 })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 100
    soundIcon.y = 50

    local soundText = display.newText({
        parent = sceneGroup,
        text = "LIGADO",
        x = soundIcon.x,
        y = soundIcon.y + 40,
        font = native.systemFontBold,
        fontSize = 20
    })
    soundText:setFillColor(0, 0, 0, 1)

    -- Sound toggle logic
    local soundHandle = true
    soundIcon:addEventListener("tap", function()
        if soundHandle then
            soundIcon.fill = { type = "image", filename = "imagens/mute.png" }
            soundText.text = "DESLIGADO"
            soundHandle = false
        else
            soundIcon.fill = { type = "image", filename = "imagens/sound.png" }
            soundText.text = "LIGADO"
            soundHandle = true
        end
    end)
end

function scene:show(event)
    if event.phase == "did" then
        print("Página 4 exibida")
        -- Add accelerometer listener
        Runtime:addEventListener("accelerometer", onAccelerometer)
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 4")
        -- Remove accelerometer listener
        Runtime:removeEventListener("accelerometer", onAccelerometer)
        cleanScene() -- Reset scene
    end
end

function scene:destroy(event)
    print("Destruindo página 4")
    cleanScene() -- Ensure no resources are lingering
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene