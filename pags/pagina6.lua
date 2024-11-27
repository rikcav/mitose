local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics")
local cells = {} -- Store created cells
local petriDish -- Reference to the petri dish object
local fixedSpots = { -- Fixed positions for cells
    { x = display.contentCenterX - 120, y = display.contentCenterY + 100 },
    { x = display.contentCenterX + 120, y = display.contentCenterY + 100 },
    { x = display.contentCenterX - 50, y = display.contentCenterY + 100 }
}

local backgroundAudio -- Variable to hold the background audio

function scene:create(event)
    local sceneGroup = self.view

    -- Start physics
    physics.start()

    -- Load the background audio
    backgroundAudio = audio.loadStream("sons/006-telofase.mp3")

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Telofase.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Navigation buttons
    local nextButton = display.newText(sceneGroup, "PRÓXIMA", 685, 990, native.systemFont, 30)
    nextButton:setFillColor(0, 0, 0, 1)
    nextButton:addEventListener("tap", function()
        composer.gotoScene("pags.contracapa", {
            effect = "slideLeft",
            time = 500
        })
    end)

    local prevButton = display.newText(sceneGroup, "ANTERIOR", 88, 990, native.systemFont, 30)
    prevButton:setFillColor(0, 0, 0, 1)
    prevButton:addEventListener("tap", function()
        composer.gotoScene("pags.pagina5", {
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
        y = soundIcon.y + 30,
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

    -- Create the petri dish as a sensor
    petriDish = display.newImageRect(sceneGroup, "imagens/telophase/petri.png", 430, 250)
    petriDish.x = display.contentCenterX
    petriDish.y = display.contentCenterY + 125
    physics.addBody(petriDish, "static", { radius = 150, isSensor = true })

    -- Create invisible boundary walls around the petri dish
    local function createBoundaryWalls()
        local dishX, dishY, radius = petriDish.x, petriDish.y, 150

        local walls = {
            { x = dishX - radius, y = dishY, width = 15, height = 2 * radius }, -- Left wall
            { x = dishX + radius, y = dishY, width = 15, height = 2 * radius }, -- Right wall
            { x = dishX, y = dishY - radius, width = 2 * radius, height = 15 }, -- Top wall
            { x = dishX, y = dishY + radius, width = 2 * radius, height = 15 } -- Bottom wall
        }

        for _, wall in ipairs(walls) do
            local boundary = display.newRect(wall.x, wall.y, wall.width, wall.height)
            physics.addBody(boundary, "static")
            boundary.isVisible = false
            sceneGroup:insert(boundary)
        end
    end

    createBoundaryWalls()

    -- Create a cell at a fixed position
    local function createPairedCells(index)
        local spot = fixedSpots[index]
        local cell1 = display.newImageRect(sceneGroup, "imagens/telophase/divided_cell.png", 42, 35)
        cell1.x = spot.x - 15
        cell1.y = spot.y
        physics.addBody(cell1, { radius = 20, bounce = 0.9, isSensor = true })
        cell1.gravityScale = 0 -- Prevent gravity from affecting cells

        local cell2 = display.newImageRect(sceneGroup, "imagens/telophase/divided_cell.png", 42, 35)
        cell2.x = spot.x + 15
        cell2.y = spot.y
        physics.addBody(cell2, { radius = 20, bounce = 0.9, isSensor = true })
        cell2.gravityScale = 0

        -- Add touch event listener to unlock cells
        local function unlockCells(event)
            if event.phase == "began" then
                cell1.isSensor = false
                cell2.isSensor = false
                cell1:setLinearVelocity(math.random(-200, 200), math.random(-200, 200))
                cell2:setLinearVelocity(math.random(-200, 200), math.random(-200, 200))
                cell1:removeEventListener("touch", unlockCells)
                cell2:removeEventListener("touch", unlockCells)
            end
        end

        cell1:addEventListener("touch", unlockCells)
        cell2:addEventListener("touch", unlockCells)

        table.insert(cells, cell1)
        table.insert(cells, cell2)
    end

    -- Generate paired cells
    for i = 1, #fixedSpots do
        createPairedCells(i)
    end
end

function scene:show(event)
    if event.phase == "did" then
        print("Página 6 exibida")
        physics.start()
        -- Play the background audio when the page is displayed
        if backgroundAudio then
            audio.play(backgroundAudio, { loops = 0 })
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        print("Saindo da página 6")
        physics.stop()

        -- Remove all cells
        for i = #cells, 1, -1 do
            if cells[i] and cells[i].removeSelf then
                cells[i]:removeSelf()
                cells[i] = nil
            end
        end
        cells = {}

        -- Stop the background audio
        if backgroundAudio then
            audio.stop()
        end
    end
end

function scene:destroy(event)
    print("Destruindo página 6")
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
