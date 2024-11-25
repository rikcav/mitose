local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Anafase.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local leftChromosome1 = display.newImageRect(sceneGroup, "imagens/anaphase/left-chromosome-1.png", 30, 13)
    leftChromosome1.x = display.contentCenterX - 14
    leftChromosome1.y = display.contentCenterY + 42

    local rightChromosome1 = display.newImageRect(sceneGroup, "imagens/anaphase/right-chromosome-1.png", 30, 13)
    rightChromosome1.x = display.contentCenterX + 14
    rightChromosome1.y = display.contentCenterY + 42

    local leftChromosome2 = display.newImageRect(sceneGroup, "imagens/anaphase/left-chromosome-2.png", 30, 13)
    leftChromosome2.x = display.contentCenterX - 14
    leftChromosome2.y = display.contentCenterY + 80

    local rightChromosome2 = display.newImageRect(sceneGroup, "imagens/anaphase/right-chromosome-2.png", 30, 13)
    rightChromosome2.x = display.contentCenterX + 14
    rightChromosome2.y = display.contentCenterY + 80

    local leftChromosome3 = display.newImageRect(sceneGroup, "imagens/anaphase/left-chromosome-1.png", 30, 13)
    leftChromosome3.x = display.contentCenterX - 14
    leftChromosome3.y = display.contentCenterY + 152

    local rightChromosome3 = display.newImageRect(sceneGroup, "imagens/anaphase/right-chromosome-1.png", 30, 13)
    rightChromosome3.x = display.contentCenterX + 14
    rightChromosome3.y = display.contentCenterY + 152

    local leftChromosome4 = display.newImageRect(sceneGroup, "imagens/anaphase/left-chromosome-2.png", 30, 13)
    leftChromosome4.x = display.contentCenterX - 14
    leftChromosome4.y = display.contentCenterY + 186

    local rightChromosome4 = display.newImageRect(sceneGroup, "imagens/anaphase/right-chromosome-2.png", 30, 13)
    rightChromosome4.x = display.contentCenterX + 14
    rightChromosome4.y = display.contentCenterY + 186

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina6", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina4", {
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

function scene:show(event)
    if event.phase == "did" then
        print("Página 5 exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 5")
    end
end

function scene:destroy(event)
    print("Destruindo página 5")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
