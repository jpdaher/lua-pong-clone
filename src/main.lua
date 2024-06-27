require("Entity")

function love.load()
    score = {p1 = 0, p2 = 0}
    p1 = PadL.new(10, 140, 10, 100, 300)
    p2 = PadR.new(620, 140, 10, 100, 300)
    ball = Ball.new(315, 235, 10, 200, 200)
    font = love.graphics.getFont()
end

function love.update(dt)
    p1:update(dt)
    p2:update(dt)
    ball:update(dt)
    
    if ball:checkCollision(p1) or ball:checkCollision(p2) then
        ball.spdX = -1 * ball.spdX
    end
    

    local ball_scoring = ball:outOfBounds()
    if ball_scoring == "left" then
        score.p2 = score.p2 + 1
    elseif ball_scoring == "right" then
        score.p1 = score.p1 + 1
    end
    if ball_scoring ~= false then
        ball = Ball.new(315, 235, 10, 200, 200)
    end
end

function love.draw()
    p1:draw()
    p2:draw()
    ball:draw()
    love.graphics.print(score.p1.. " - ".. score.p2, 320 - 2 * font:getWidth("0 - 0"), 20, 0, 4, 4)
end