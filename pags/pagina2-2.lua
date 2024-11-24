local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Introducao-2.png", display.contentWidth,
        display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", display.contentWidth - 80, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina3", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", display.contentCenterX, 100, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina2", {
            effect = "slideDown",
            time = 500
        })
    end)

    -- Opaque white circle in the center of the page
    local microscopeCircle = display.newCircle(sceneGroup, 605, 620, 30)
    microscopeCircle:setFillColor(1, 1, 1, 0.5) -- White with 50% opacity
    microscopeCircle:addEventListener("tap", function()
        -- Create a semi-transparent background to highlight the image
        local overlay = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY,
            display.contentWidth, display.contentHeight)
        overlay:setFillColor(0, 0, 0, 0.5) -- Black with 50% opacity

        -- Create a square to display the animation
        local imageSquare = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, 250, 145)
        imageSquare:setFillColor(1, 1, 1) -- White background for the square

        -- Animation variables
        local frameIndex = 0
        local maxFrames = 8
        local image
        local animationTimer

        -- Function to update the image
        local function updateFrame()
            if image then
                image:removeSelf()
            end -- Remove the previous image
            image = display.newImageRect(sceneGroup, "imagens/cell_division/" .. frameIndex .. ".png", 240, 135)
            image.x = display.contentCenterX
            image.y = display.contentCenterY
            frameIndex = frameIndex + 1
            if frameIndex > maxFrames then
                frameIndex = 0
            end -- Loop back to the first frame
        end

        -- Start the animation
        animationTimer = timer.performWithDelay(200, updateFrame, 0) -- Update every 200ms

        -- Close button
        local closeButton = display.newText(sceneGroup, "FECHAR", display.contentCenterX, display.contentCenterY + 120,
            native.systemFont, 24)
        closeButton:setFillColor(1, 1, 1, 1)

        -- Close functionality
        closeButton:addEventListener("tap", function()
            -- Stop the animation
            if animationTimer then
                timer.cancel(animationTimer)
            end
            -- Remove all display objects
            overlay:removeSelf()
            imageSquare:removeSelf()
            if image then
                image:removeSelf()
            end
            closeButton:removeSelf()
        end)
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
