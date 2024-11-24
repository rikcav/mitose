local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "imagens/Contracapa.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local restartButton = display.newText(sceneGroup, "INÍCIO", 685, 990, native.systemFont, 30)
    restartButton:setFillColor(0, 0, 1)

    restartButton:addEventListener("tap", function()
        composer.gotoScene("pags.capa", {
            effect = "crossFade",
            time = 500
        })
    end)
end

function scene:show(event)
    if event.phase == "did" then
        print("Contracapa exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da contracapa")
    end
end

function scene:destroy(event)
    print("Destruindo contracapa")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
