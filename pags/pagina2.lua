local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)

    local pageText = display.newText(sceneGroup, "Página 2", display.contentCenterX, display.contentCenterY, native.systemFont, 40)

    local nextButton = display.newText(sceneGroup, "Próxima página", 685, 930, native.systemFont, 30)
    local prevButton = display.newText(sceneGroup, "Página anterior", 48, 930, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 1)
    prevButton:setFillColor(0, 0, 1)

    nextButton:addEventListener("tap", function() composer.gotoScene("pags.pagina3", {effect = "slideLeft", time = 500}) end)
    prevButton:addEventListener("tap", function() composer.gotoScene("pags.capa", {effect = "slideRight", time = 500}) end)
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
