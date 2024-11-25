local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Anafase.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Function to add dragging logic to a chromosome
    local function makeDraggable(chromosome)
        local function drag(event)
            local phase = event.phase
            local target = event.target

            if phase == "began" then
                display.currentStage:setFocus(target)
                target.touchOffsetX = event.x - target.x

            elseif phase == "moved" then
                -- Update chromosome position along x-axis
                target.x = event.x - target.touchOffsetX

                -- Constrain chromosome within screen bounds
                if target.x < display.contentCenterX - 100 then
                    target.x = display.contentCenterX - 100
                elseif target.x > display.contentCenterX + 100 then
                    target.x = display.contentCenterX + 100
                end

            elseif phase == "ended" or phase == "cancelled" then
                display.currentStage:setFocus(nil)
            end

            return true
        end

        chromosome:addEventListener("touch", drag)
    end

    -- Create chromosomes with dragging functionality
    local chromosomes = {{
        image = "imagens/anaphase/left-chromosome-1.png",
        x = display.contentCenterX - 14,
        y = display.contentCenterY + 42
    }, {
        image = "imagens/anaphase/right-chromosome-1.png",
        x = display.contentCenterX + 14,
        y = display.contentCenterY + 42
    }, {
        image = "imagens/anaphase/left-chromosome-2.png",
        x = display.contentCenterX - 14,
        y = display.contentCenterY + 80
    }, {
        image = "imagens/anaphase/right-chromosome-2.png",
        x = display.contentCenterX + 14,
        y = display.contentCenterY + 80
    }, {
        image = "imagens/anaphase/left-chromosome-1.png",
        x = display.contentCenterX - 14,
        y = display.contentCenterY + 152
    }, {
        image = "imagens/anaphase/right-chromosome-1.png",
        x = display.contentCenterX + 14,
        y = display.contentCenterY + 152
    }, {
        image = "imagens/anaphase/left-chromosome-2.png",
        x = display.contentCenterX - 14,
        y = display.contentCenterY + 186
    }, {
        image = "imagens/anaphase/right-chromosome-2.png",
        x = display.contentCenterX + 14,
        y = display.contentCenterY + 186
    }}

    for _, data in ipairs(chromosomes) do
        local chromosome = display.newImageRect(sceneGroup, data.image, 30, 13)
        chromosome.x = data.x
        chromosome.y = data.y
        makeDraggable(chromosome)
    end

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina6", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina4", {
            effect = "slideRight",
            time = 500
        })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
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
        else
            soundIcon.fill = {
                type = "image",
                filename = "imagens/sound.png"
            }
            soundText.text = "LIGADO"
            soundHandle = true
        end
    end)
end

function scene:show(event)
    if event.phase == "did" then
        print("Página 5 exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 5")
    end
end

function scene:destroy(event)
    print("Destruindo página 5")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
