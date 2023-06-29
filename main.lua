local Tetros = {}
Tetros[1] = {{
    {0,0,0,0},
    {0,0,0,0},
    {1,1,1,1},
    {0,0,0,0}
    },
    {
    {0,0,1,0},
    {0,0,1,0},
    {0,0,1,0},
    {0,0,1,0}       
    }
}
Tetros[1].color = {0.16, 0.67, 0.88}
Tetros[2] = { {
    {0,0,0,0},
    {0,1,1,0},
    {0,1,1,0},
    {0,0,0,0}
    } }
Tetros[2].color = {0.99, 0.88, 0}
Tetros[3] = {
    {
    {0,1,0},
    {0,1,0},
    {1,1,0},
    },
    {
    {1,0,0},
    {1,1,1},
    {0,0,0},
    },
    {
    {0,1,1},
    {0,1,0},
    {0,1,0},
    },
    {
    {0,0,0},
    {1,1,1},
    {0,0,1},
    } }
Tetros[3].color = {0, 0.35, 0.61}
Tetros[4] = { {
    {0,0,0},
    {0,1,1},
    {1,1,0},
    },
    {
    {0,1,0},
    {0,1,1},
    {0,0,1},
    },
}
Tetros[4].color = {0.3,0.71,0.28}
Tetros[5] = {
    {
        {1,1,0},
        {0,1,1},
        {0,0,0},
        },
        {
        {0,1,0},
        {1,1,0},
        {1,0,0},
        }
}
Tetros[5].color = { 0.93, 0.15, 0.2}
Tetros[6] = { {
    {0,0,0},
    {1,1,1},
    {0,1,0},
    },
    {
    {0,1,0},
    {0,1,1},
    {0,1,0},
    },
    {
    {0,1,0},
    {1,1,1},
    {0,0,0},
    },
    {
    {0,1,0},
    {1,1,0},
    {0,1,0},
    } }
Tetros[6].color = {0.57,0.16,0.54}
Tetros[7] = {
    {
        {0,1,0},
        {0,1,0},
        {0,1,1}
    },
    {
        {0,0,1},
        {1,1,1},
        {0,0,0}
    },
    {
        {1,1,0},
        {0,1,0},
        {0,1,0}
    },
    {
        {0,0,0},
        {1,1,1},
        {1,0,0}
    }
}
Tetros[7].color = { 0.97, 0.58, 0.13}
local currrentRotation = 1
local currentTetros = 1

local Grid = {}
Grid.width = 10
Grid.height = 20
Grid.cells = {}

function InitGrid()
    Grid.cellSize = screen_height / Grid.height
    Grid.offsetX = (screen_width / 2 ) - ((Grid.cellSize * Grid.width ) / 2)
    Grid.offsetY = 0

    for l = 1, Grid.height do
        Grid.cells[l] = {}
        for c = 1, Grid.width do
            Grid.cells[l][c] = 0
        end
    end
end

function DrawGrid()
    love.graphics.setColor(1,1,1,0.25)
    local x,y
    for l = 1, Grid.height do
        for c = 1, Grid.width do
            x = (c-1)*Grid.cellSize
            y = (l-1)*Grid.cellSize
            x = x + Grid.offsetX
            y = y + Grid.offsetY
            love.graphics.rectangle('line',x,y, Grid.cellSize-1, Grid.cellSize-1)
        end
    end
end

function love.load()
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    InitGrid()
end

function love.update(dt)
    
end

function love.draw()
    local Shape = Tetros[currentTetros][currrentRotation]
    DrawGrid()
    for l = 1, #Shape do
        for c = 1, #Shape[l] do
            if Shape[l][c] == 1 then
                local x = (c-1)*32
                local y = (l-1)*32
                love.graphics.setColor(Tetros[currentTetros].color)
                love.graphics.rectangle('fill',x,y,31,31)
            end
        end
    end
end

function love.keypressed(key)
    if key == 't' then
        currentTetros = currentTetros + 1
        if currentTetros > #Tetros then currentTetros = 1 end
        currrentRotation = 1
    end

    if key == 'r' then
        currrentRotation = currrentRotation + 1
        if currrentRotation > #Tetros[currentTetros] then currrentRotation = 1 end
    end
end