local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Introducao.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 388, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2-2", {
            effect = "slideUp",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.capa", {
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
        print("Página 2 exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 2")
    end
end

function scene:destroy(event)
    print("Destruindo página 2")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
