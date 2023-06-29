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

local currentTetros = {}
currentTetros.shape = 1
currentTetros.rotation = 1
currentTetros.position = { x = 0 , y = 0}

local Grid = {}
Grid.width = 10
Grid.height = 20
Grid.cells = {}

function SpawnTetros()
    currentTetros.shape = math.random(1, #Tetros)
    -- currentTetros.rotation = math.random(1, #Tetros)
    currentTetros.position.x = Grid.offsetX
    currentTetros.position.y = Grid.offsetY
end

function InitGame()
    
end

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

function DrawTetros(pShape, pX, pY, pT)
    for l = 1, #pShape do
        for c = 1, #pShape[l] do
            if pShape[l][c] == 1 then
                local x = (c-1)*Grid.cellSize
                local y = (l-1)*Grid.cellSize
                x = pX + x + (Grid.cellSize*(math.floor(Grid.width/2)-(pT-2)))
                y = pY + y
                love.graphics.setColor(Tetros[currentTetros.shape].color)
                love.graphics.rectangle('fill',x,y,Grid.cellSize - 1,Grid.cellSize - 1)
            end
        end
    end
end

function love.load()
    math.randomseed(os.time())
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    InitGrid()
    SpawnTetros()
end

function love.update(dt)
    
end

function love.draw()
    
    local Shape = Tetros[currentTetros.shape][currentTetros.rotation]
    DrawGrid()
    taille = 0
    for _ in pairs(Shape) do taille = taille + 1 end
    love.graphics.print('Shape : ' ..tostring(taille))
    DrawTetros(Shape, currentTetros.position.x, currentTetros.position.y, taille)
    
end

function love.keypressed(key)
    if key == 't' then
        currentTetros.shape = currentTetros.shape + 1
        if currentTetros.shape > #Tetros then currentTetros.shape = 1 end
        currentTetros.rotation = 1
    end

    if key == 'r' then
        currentTetros.rotation = currentTetros.rotation + 1
        if currentTetros.rotation > #Tetros[currentTetros.shape] then currentTetros.rotation = 1 end
    end
end