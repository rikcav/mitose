local composer = require("composer")
local scene = composer.newScene()

local backgroundMusic -- Variável para armazenar o áudio
local musicChannel -- Canal do áudio

function scene:create(event)
    local sceneGroup = self.view

    -- Carregar o áudio
    backgroundMusic = audio.loadStream("sons/001-ozzy.mp3")

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
    soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
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
            audio.pause(musicChannel) -- Pausar música
        else
            soundIcon.fill = {
                type = "image",
                filename = "imagens/sound.png"
            }
            soundText.text = "LIGADO"
            soundHandle = true
            audio.resume(musicChannel) -- Retomar música
        end
    end)
end

function scene:show(event)
    if event.phase == "did" then
        print("Página exibida")
        -- Tocar música de fundo
        if backgroundMusic then
            musicChannel = audio.play(backgroundMusic, { loops = 0 })
        else
            print("Erro: Áudio não encontrado.")
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página")
        -- Pausar música ao sair
        if musicChannel then
            audio.pause(musicChannel)
        end
    end
end

function scene:destroy(event)
    print("Destruindo página")
    -- Liberar memória do áudio
    if backgroundMusic then
        audio.dispose(backgroundMusic)
        backgroundMusic = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
