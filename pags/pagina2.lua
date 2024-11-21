local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)

    -- Page title
    local pageText = display.newText(sceneGroup, "Página 2", display.contentCenterX, display.contentCenterY, native.systemFont, 40)

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "Próxima", 685, 930, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 1)

    local prevButton = display.newText(sceneGroup, "Anterior", 48, 930, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 1)

    -- Navigate to page 3
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina3", {effect = "slideLeft", time = 500})
    end)

    -- Navigate to the cover page
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.capa", {effect = "slideRight", time = 500})
    end)

    -- Sound control
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 40
    soundIcon.y = 40

    local soundText = display.newText(sceneGroup, "Ligado", soundIcon.x, soundIcon.y + 40, native.systemFontBold, 20)
    soundText:setFillColor(65 / 255, 97 / 255, 176 / 255, 1)

    local isMuted = false
    soundIcon:addEventListener("tap", function()
        if isMuted then
            soundIcon.fill = {type = "image", filename = "imagens/sound.png"}
            soundText.text = "Ligado"
            audio.setVolume(1)
        else
            soundIcon.fill = {type = "image", filename = "imagens/mute.png"}
            soundText.text = "Desligado"
            audio.setVolume(0)
        end
        isMuted = not isMuted
    end)

    -- Load and play background music
    local backgroundMusic = audio.loadStream("sons/001-ozzy.mp3")
    if not backgroundMusic then
        print("Erro: Não foi possível carregar sons/001-ozzy.mp3")
    else
        self.backgroundMusic = backgroundMusic -- Save for later use
    end
end

function scene:show(event)
    if event.phase == "did" then
        print("Página 2 exibida")
        -- Play background music
        if self.backgroundMusic then
            self.musicChannel = audio.play(self.backgroundMusic, {loops = -1})
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 2")
        -- Stop music
        if self.musicChannel then
            audio.stop(self.musicChannel)
            self.musicChannel = nil
        end
    end
end

function scene:destroy(event)
    print("Destruindo página 2")
    -- Dispose of background music
    if self.backgroundMusic then
        audio.dispose(self.backgroundMusic)
        self.backgroundMusic = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
