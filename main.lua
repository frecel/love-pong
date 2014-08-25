state = 0 -- 0 is menu 1 is game


function menu()
  function love.keypressed(key)
    if key == "down" and highlighted < 3 then
      highlighted = highlighted + 1
      highlightpos = highlightpos + 50
    elseif key == "up" and highlighted > 1 then
      highlighted = highlighted -1
      highlightpos = highlightpos - 50
    elseif key == "return" and highlighted == 1 then
      state = 1
    elseif key == "return" and highlighted == 3 then
      love.event.quit()
    end
  end
end

function menudraw()
    love.graphics.setColor(45, 154, 255, 50)
    love.graphics.rectangle("fill", 250, highlightpos, 400, 50)
    love.graphics.setColor(0,0,0)
    love.graphics.setNewFont(100)
    love.graphics.print("Love-Pong", 200, 50)
    love.graphics.setNewFont(50)
    love.graphics.print("Start Game", 300, 150)
    love.graphics.print("Options", 300, 200)
    love.graphics.print("Quit", 300, 250)
end

function love.load()
  --menu stuff
  highlighted = 1
  highlightpos = 150
  
  
  --ball image and starting coordinates
  ball = {}
  ball.image = love.graphics.newImage("gfx/ball.png")
  ball.x = 375
  ball.y = 275
  ball.speed = 3 -- speed of the ball keep less then 25 otherwise it may fly through paddles
  paddlespeed = 3
  ball.addx = ball.speed
  ball.addy = ball.speed
  --left paddle and starting coordinates
  paddleL = {}
  paddleL.image = love.graphics.newImage("gfx/paddle.png")
  paddleL.x = 20
  paddleL.y = 225
  --right paddle and starting coordinates
  paddleR = {}
  paddleR.image = love.graphics.newImage("gfx/paddle.png")
  paddleR.x = 755
  paddleR.y = 225
  --scores
  score = {}
  score.l = 0
  score.r = 0
  love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
  if state == 0 then
    menu()
  end
   
  if state == 1 then
    function love.keypressed(key)
      if key == "escape" then
	state = 0
      end
    end    
    --paddle movement
    if love.keyboard.isDown("a") and paddleL.y >= 0 then
      paddleL.y = paddleL.y - paddlespeed
    elseif love.keyboard.isDown("z") and paddleL.y <= 450 then
      paddleL.y = paddleL.y + paddlespeed
    end
  
    if love.keyboard.isDown("k") and paddleR.y >= 0 then
      paddleR.y = paddleR.y - paddlespeed
    elseif love.keyboard.isDown("m") and paddleR.y <= 450 then
      paddleR.y = paddleR.y + paddlespeed
    end
 
    --ball movement
    ball.x = ball.x + ball.addx
    ball.y = ball.y + ball.addy
  
    --bouce off top edges  
    if ball.y >= 550 then
      ball.addy = -3
    elseif ball.y <= 0 then
      ball.addy = ball.speed
    end
  
    --bouce off paddles
    if ball.x >= 705 and ball.x <= 730 and ball.y >= paddleR.y and ball.y <= paddleR.y + 150 then
      ball.addx = -ball.speed
    end
  
    if ball.x <= 45 and ball.x >= 20 and ball.y >= paddleL.y and ball.y <= paddleL.y + 150 then
      ball.addx = ball.speed
    end
  
    --scoring  
    if ball.x == 0 then
      score.r = score.r + 1
      ball.x = 375
      ball.y = 275
      ball.addx = ball.speed
    elseif ball.x == 750 then
      score.l = score.l + 1
      ball.x = 375
      ball.y = 275
      ball.addx = -ball.speed
    end
  end
end

function love.draw()
  if state == 0 then
    menudraw()
  end
  
  if state == 1 then
    love.graphics.setColor(0,0,0)
    love.graphics.setNewFont(40)
    love.graphics.print(score.l, 350, 10)
    love.graphics.print(score.r, 420, 10)
    love.graphics.setColor(45, 154, 255, 50)
    love.graphics.rectangle("fill", 390, 0, 20, 600)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(paddleL.image, paddleL.x, paddleL.y)
    love.graphics.draw(paddleR.image, paddleR.x, paddleR.y)
    love.graphics.draw(ball.image, ball.x, ball.y)
  end
end

