local composer = require("composer")
local scene = composer.newScene()

local chromosomes = {} -- Store chromosome objects for easy access

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Metafase.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local metaphaseEmpty = display.newImageRect(sceneGroup, "imagens/metaphase/metaphase-empty.png", 145, 161)
    metaphaseEmpty.x = display.contentCenterX
    metaphaseEmpty.y = display.contentCenterY + 90

    local chromosome1 = display.newImageRect(sceneGroup, "imagens/metaphase/chromosome-1.png", 26, 14)
    chromosome1.x = display.contentCenterX - 25
    chromosome1.y = display.contentCenterY + 80
    table.insert(chromosomes, chromosome1)

    local chromosome2 = display.newImageRect(sceneGroup, "imagens/metaphase/chromosome-2.png", 26, 14)
    chromosome2.x = display.contentCenterX + 25
    chromosome2.y = display.contentCenterY + 110
    table.insert(chromosomes, chromosome2)

    local chromosome3 = display.newImageRect(sceneGroup, "imagens/metaphase/chromosome-1.png", 26, 14)
    chromosome3.x = display.contentCenterX - 15
    chromosome3.y = display.contentCenterY + 60
    table.insert(chromosomes, chromosome3)

    local chromosome4 = display.newImageRect(sceneGroup, "imagens/metaphase/chromosome-2.png", 26, 14)
    chromosome4.x = display.contentCenterX + 35
    chromosome4.y = display.contentCenterY + 120
    table.insert(chromosomes, chromosome4)

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina5", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina3", {
            effect = "slideRight",
            time = 500
        })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 100
    soundIcon.y = 50

    -- Sound status text
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
            soundIcon.fill = {
                type = "image",
                filename = "imagens/mute.png"
            }
            soundText.text = "DESLIGADO"
            soundHandle = false
        else
            soundIcon.fill = {
                type = "image",
                filename = "imagens/sound.png"
            }
            soundText.text = "LIGADO"
            soundHandle = true
        end
    end)
end

-- Accelerometer event listener to move all chromosomes
local function onAccelerometer(event)
    -- Check if the accelerometer readings exceed a certain threshold
    if math.abs(event.xInstant) > 1.5 or math.abs(event.yInstant) > 1.5 or math.abs(event.zInstant) > 1.5 then
        print("Accelerometer triggered! Moving chromosomes.")

        -- Move each chromosome to its aligned position
        transition.to(chromosomes[1], {
            time = 500,
            x = 313,
            y = 656
        })
        transition.to(chromosomes[2], {
            time = 500,
            x = 368,
            y = 656
        })
        transition.to(chromosomes[3], {
            time = 500,
            x = 313,
            y = 680
        })
        transition.to(chromosomes[4], {
            time = 500,
            x = 368,
            y = 680
        })

        -- Remove accelerometer listener after moving the chromosomes
        Runtime:removeEventListener("accelerometer", onAccelerometer)
        print("Chromosomes aligned. Accelerometer listener removed.")
    end
end

function scene:show(event)
    if event.phase == "did" then
        print("Página 4 exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 4")
    end
end

function scene:destroy(event)
    print("Destruindo página 4")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
