local composer = require("composer")
local scene = composer.newScene()

local backgroundAudio -- Variable for the audio

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Capa.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- "Next Page" text
    local nextText = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextText:setFillColor(100, 100, 100, 1)

    -- Navigation to the next page
    nextText:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2", {
            effect = "slideLeft",
            time = 500
        })
    end)

    -- "Next button"
    local nextButton = display.newImageRect(sceneGroup, "imagens/right_arrow.png", 60, 60)
    nextButton.x = 687
    nextButton.y = 940

    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2", {
            effect = "slideLeft",
            time = 500
        })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 60
    soundIcon.y = 40

    -- Text for sound status
    local soundText = display.newText({
        parent = sceneGroup,
        text = "LIGADO",
        x = soundIcon.x,
        y = soundIcon.y + 40,
        font = native.systemFontBold,
        fontSize = 20
    })
    soundText:setFillColor(100, 100, 100, 1)

    -- Load the background audio
    backgroundAudio = audio.loadStream("sons/000-capa.mp3")

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
            audio.setVolume(0) -- Mute the audio
        else
            soundIcon.fill = {
                type = "image",
                filename = "imagens/sound.png"
            }
            soundText.text = "LIGADO"
            soundHandle = true
            audio.setVolume(1) -- Unmute the audio
        end
    end)
end

function scene:show(event)
    if event.phase == "did" then
        print("Capa exibida")
        -- Play the background audio when the page is displayed
        if backgroundAudio then
            audio.play(backgroundAudio, { loops = 0 })
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da capa")
        -- Stop the background audio when leaving the page
        if backgroundAudio then
            audio.stop()
        end
    end
end

function scene:destroy(event)
    print("Destruindo capa")
    -- Dispose of the background audio
    if backgroundAudio then
        audio.dispose(backgroundAudio)
        backgroundAudio = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
