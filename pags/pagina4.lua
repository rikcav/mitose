local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth,
        display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)

    -- Page text
    local pageText = display.newText(sceneGroup, "Página 4", display.contentCenterX, display.contentCenterY,
        native.systemFont, 40)

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(100, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina5", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(100, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina3", {
            effect = "slideRight",
            time = 500
        })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 60
    soundIcon.y = 40

    -- Sound status text
    local soundText = display.newText({
        parent = sceneGroup,
        text = "Ligado",
        x = soundIcon.x,
        y = soundIcon.y + 40,
        font = native.systemFontBold,
        fontSize = 20
    })
    soundText:setFillColor(100, 0, 0, 1)

    -- Sound toggle logic
    local soundHandle = true
    soundIcon:addEventListener("tap", function()
        if soundHandle then
            soundIcon.fill = {
                type = "image",
                filename = "imagens/mute.png"
            }
            soundText.text = "Desligado"
            soundHandle = false
        else
            soundIcon.fill = {
                type = "image",
                filename = "imagens/sound.png"
            }
            soundText.text = "Ligado"
            soundHandle = true
        end
    end)
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
