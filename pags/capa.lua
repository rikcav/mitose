local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "imagens/Capa.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local nextButton = display.newText(sceneGroup, "Próxima Página", 685, 930, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 1)

    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2", {effect = "slideLeft", time = 500})
    end)
end

function scene:show(event)
    if event.phase == "did" then
        print("Capa exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da capa")
    end
end

function scene:destroy(event)
    print("Destruindo capa")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
