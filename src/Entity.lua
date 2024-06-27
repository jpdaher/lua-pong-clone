-- --- ENTITY ---

Entity = {}
Entity.__index = Entity

function Entity:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Entity:hitWall()
    if self.y <= 0 then
        self.y = 0
        return true
    end
    if self.y + self.height >= 480 then
        self.y = 480 - self.height
        return true
    end
end

function Entity:checkCollision(e)
    if
        self.x < e.x + e.width and
        self.x + self.width > e.x and
        self.y < e.y + e.height and
        self.y + self.height > e.y
    then
        return true
    end
    return false
end

-- --- PADS ---

PadR = {}
PadR.__index = PadR
setmetatable(PadR, Entity)

function PadR.new(x, y, width, height, spdY)
    local instance = setmetatable({}, PadR)
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.spdY = spdY
    return instance
end

function PadR:update(dt)
    self:hitWall()

    if love.keyboard.isDown("up") then
        self.y = self.y - self.spdY * dt
    elseif love.keyboard.isDown("down") then
        self.y = self.y + self.spdY * dt
    end
end

PadL = {}
PadL.__index = PadL
setmetatable(PadL, Entity)

function PadL.new(x, y, width, height, spdY)
    local instance = setmetatable({}, PadL)
    instance.x = x
    instance.y = y
    instance.width = width
    instance.height = height
    instance.spdY = spdY
    return instance
end

function PadL:update(dt)
    self:hitWall()

    if love.keyboard.isDown("w") then
        self.y = self.y - self.spdY * dt
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.spdY * dt
    end
end

-- --- BALL ---

Ball = {}
Ball.__index = Ball
setmetatable(Ball, Entity)

function Ball.new(x, y, radius, spdX, spdY)
    local instance = setmetatable({}, Ball)
    instance.x = x
    instance.y = y
    instance.width = radius
    instance.height = radius
    if math.random(0, 1) == 0 then
        instance.spdX = -spdX
    else instance.spdX = spdX
    end
    if math.random(2, 3) == 2 then
        instance.spdY = -spdY
    else instance.spdY = spdY
    end
    return instance
end

function Ball:update(dt)
    if self:hitWall() then
        self.spdY = -self.spdY
    end

    self.x = self.x + self.spdX * dt
    self.y = self.y + self.spdY * dt
end

function Ball:outOfBounds()
    if self.x < 0 then
        return "left"
    end
    if self.x + self.width > 640 then
        return "right"
    end
    return false
end