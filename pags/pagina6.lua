local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics")
local cells = {} -- Store created cells
local petriDish -- Reference to the petri dish object
local fixedSpots = { -- Fixed positions for cells
{
    x = display.contentCenterX - 120,
    y = display.contentCenterY + 100
}, {
    x = display.contentCenterX + 120,
    y = display.contentCenterY + 100
}, {
    x = display.contentCenterX - 50,
    y = display.contentCenterY + 100
}}

function scene:create(event)
    local sceneGroup = self.view

    -- Start physics
    physics.start()

    -- Background image
    local background = display.newImageRect(sceneGroup, "imagens/Telofase.png", display.contentWidth,
        display.contentHeight)
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

    -- Create the petri dish as a sensor
    petriDish = display.newImageRect(sceneGroup, "imagens/telophase/petri.png", 430, 250)
    petriDish.x = display.contentCenterX
    petriDish.y = display.contentCenterY + 125
    physics.addBody(petriDish, "static", {
        radius = 150,
        isSensor = true
    }) -- Make the petri dish a sensor

    -- Create invisible boundary walls around the petri dish
    local function createBoundaryWalls()
        local dishX, dishY, radius = petriDish.x, petriDish.y, 150

        -- Left wall
        local leftWall = display.newRect(dishX - radius, dishY, 10, 2 * radius)
        physics.addBody(leftWall, "static")
        leftWall.isVisible = false
        sceneGroup:insert(leftWall)

        -- Right wall
        local rightWall = display.newRect(dishX + radius, dishY, 10, 2 * radius)
        physics.addBody(rightWall, "static")
        rightWall.isVisible = false
        sceneGroup:insert(rightWall)

        -- Top wall
        local topWall = display.newRect(dishX, dishY - radius, 2 * radius, 10)
        physics.addBody(topWall, "static")
        topWall.isVisible = false
        sceneGroup:insert(topWall)

        -- Bottom wall
        local bottomWall = display.newRect(dishX, dishY + radius, 2 * radius, 10)
        physics.addBody(bottomWall, "static")
        bottomWall.isVisible = false
        sceneGroup:insert(bottomWall)
    end

    createBoundaryWalls()

    -- Create a cell at a fixed position
    local function createPairedCells(index)
        local spot = fixedSpots[index]
        local cell1 = display.newImageRect(sceneGroup, "imagens/telophase/divided_cell.png", 42, 35)
        cell1.x = spot.x - 15
        cell1.y = spot.y
        physics.addBody(cell1, {
            radius = 15,
            bounce = 0.9,
            isSensor = true
        })
        cell1.gravityScale = 0 -- Prevent gravity from affecting cells

        local cell2 = display.newImageRect(sceneGroup, "imagens/telophase/divided_cell.png", 42, 35)
        cell2.x = spot.x + 15
        cell2.y = spot.y
        physics.addBody(cell2, {
            radius = 15,
            bounce = 0.9,
            isSensor = true
        })
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
    end
end

function scene:destroy(event)
    print("Destruindo página 6")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
