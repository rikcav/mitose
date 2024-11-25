local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Profase.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Prophase cell structure
    local prophase_cell = display.newImageRect(sceneGroup, "imagens/prophase/prophase-empty.png", 145, 151)
    prophase_cell.x = display.contentCenterX
    prophase_cell.y = display.contentCenterY + 153

    -- Nucleus as a pink circle
    local nucleusX = display.contentCenterX
    local nucleusY = display.contentCenterY + 153
    local nucleusRadius = 40
    local nucleus = display.newCircle(sceneGroup, nucleusX, nucleusY, nucleusRadius)
    nucleus:setFillColor(1, 0.75, 0.8) -- Pink color (RGB: 1, 0.75, 0.8)

    -- Chromosomes (fixed positions inside the nucleus)
    local chromosomes = {}
    local chromosomeImages = {
        "imagens/prophase/chromosome-1.png",
        "imagens/prophase/chromosome-2.png",
        "imagens/prophase/chromosome-1.png",
        "imagens/prophase/chromosome-2.png"
    }
    local chromosomePositions = {
        { x = nucleusX - 10, y = nucleusY - 10 },
        { x = nucleusX + 10, y = nucleusY - 10 },
        { x = nucleusX - 10, y = nucleusY + 10 },
        { x = nucleusX + 10, y = nucleusY + 10 }
    }

    for i = 1, #chromosomeImages do
        local chromosome = display.newImageRect(sceneGroup, chromosomeImages[i], 22, 12)
        chromosome.x = chromosomePositions[i].x
        chromosome.y = chromosomePositions[i].y
        table.insert(chromosomes, chromosome)
    end

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina4", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2-2", {
            effect = "slideRight",
            time = 500
        })
    end)

    -- Sound toggle button
    local soundIcon = display.newImageRect(sceneGroup, "imagens/sound.png", 50, 50)
    soundIcon.x = display.contentWidth - 100
    soundIcon.y = 50

    local soundText = display.newText({
        parent = sceneGroup,
        text = "LIGADO",
        x = soundIcon.x,
        y = soundIcon.y + 40,
        font = native.systemFontBold,
        fontSize = 20
    })
    soundText:setFillColor(0, 0, 0, 1)

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

    -- Function to open the nucleus
    local function openNucleus(event)
        if event.phase == "moved" then
            local scale = math.abs(event.x - event.xStart) + math.abs(event.y - event.yStart)

            if scale > 50 then
                -- Animate nucleus disappearance
                transition.to(nucleus, {
                    time = 500,
                    xScale = 0.5,
                    yScale = 0.5,
                    alpha = 0,
                    onComplete = function()
                        nucleus:removeSelf()
                        nucleus = nil
                    end
                })

                -- Move chromosomes into position
                for i, chromosome in ipairs(chromosomes) do
                    transition.to(chromosome, {
                        time = 1000,
                        x = display.contentCenterX + (i % 2 == 0 and 10 or -10),
                        y = display.contentCenterY + 100 + (i * 20),
                        transition = easing.outBounce
                    })
                end

                Runtime:removeEventListener("touch", openNucleus) -- Remove interaction event
            end
        end
    end

    Runtime:addEventListener("touch", openNucleus)
end

function scene:show(event)
    if event.phase == "did" then
        print("Página 3 exibida")
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 3")
        Runtime:removeEventListener("touch", openNucleus)
    end
end

function scene:destroy(event)
    print("Destruindo página 3")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
