local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view

  local background = display.newImageRect(sceneGroup, "imagens/Capa.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local nextButton = display.newText(sceneGroup, "", 685, 930, native.systemFont, 30)
  nextButton:setFillColor(0, 0, 1)

  local function gotoPage2()
    composer.gotoScene("pags.pagina2")
  end

  nextButton:addEventListener("tap", gotoPage2)
end

scene:addEventListener("create", scene)
return scene
