local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "imagens/Contracapa.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local homeText = display.newText(sceneGroup, "INÍCIO", 688, 990, native.systemFont, 30)
    homeText:setFillColor(100, 100, 100, 1)

    homeText:addEventListener("tap", function()
        composer.gotoScene("pags.capa", {
            effect = "crossFade",
            time = 500
        })
    end)

    local homeButton = display.newImageRect(sceneGroup, "imagens/up_arrow.png", 60, 60)
    homeButton.x = 687
    homeButton.y = 940
    homeButton.alpha = 0.1

    homeButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevText = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevText:setFillColor(100, 100, 100, 1)

    prevText:addEventListener("tap", function()
        composer.gotoScene("pags.pagina6", {
            effect = "slideRight",
            time = 500
        })
    end)

    local prevButton = display.newImageRect(sceneGroup, "imagens/left_arrow.png", 60, 60)
    prevButton.x = 80
    prevButton.y = 940
    prevButton.alpha = 0.1

    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina6", {
            effect = "slideRight",
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
