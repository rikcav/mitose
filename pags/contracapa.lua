local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view

  local background = display.newImageRect(sceneGroup, "imagens/Contracapa.png", display.contentWidth,
    display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local restartButton = display.newText(sceneGroup, "", 685, 930, native.systemFont, 30)
  restartButton:setFillColor(0, 0, 1)

  local prevButton = display.newText(sceneGroup, "", 48, 930, native.systemFont, 30)
  prevButton:setFillColor(0, 0, 1)

  local function gotoCapa()
    composer.gotoScene("pags.capa")
  end

  local function gotoPrevPage()
    composer.gotoScene("pags.pagina6")
  end

  restartButton:addEventListener("tap", gotoCapa)
  prevButton:addEventListener("tap", gotoPrevPage)
end

scene:addEventListener("create", scene)
return scene
