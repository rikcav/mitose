local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth,
        display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)

    -- Page text
    local pageText = display.newText(sceneGroup, "Página 3", display.contentCenterX, display.contentCenterY,
        native.systemFont, 40)

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "Próxima", 685, 930, native.systemFont, 30)
    nextButton:setFillColor(100, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina4", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "Anterior", 48, 930, native.systemFont, 30)
    prevButton:setFillColor(100, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2", {
            effect = "slideRight",
            time = 500
        })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 40
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
        print("Página 3 exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 3")
    end
end

function scene:destroy(event)
    print("Destruindo página 3")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
