local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view

  local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth,
    display.contentHeight)
  background:setFillColor(0.9, 0.9, 0.9)   -- Cinza claro

  local pageText = display.newText(sceneGroup, "Página 2", display.contentCenterX, display.contentCenterY,
    native.systemFont, 40)

  local nextButton = display.newText(sceneGroup, "Próxima página", 685, 930, native.systemFont, 30)
  nextButton:setFillColor(0, 0, 1)

  local prevButton = display.newText(sceneGroup, "Página anterior", 48, 930, native.systemFont, 30)
  prevButton:setFillColor(0, 0, 1)

  local function gotoNextPage()
    composer.gotoScene("pags.pagina3")
  end

  local function gotoPrevPage()
    composer.gotoScene("pags.capa")
  end

  nextButton:addEventListener("tap", gotoNextPage)
  prevButton:addEventListener("tap", gotoPrevPage)
end

scene:addEventListener("create", scene)
return scene
