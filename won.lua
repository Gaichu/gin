--won.lua appears after colliding with father elhuron

won = gamestate.new();

local lg = love.graphics;

function won:init()
  local font = lg.newFont("fonts/PixAntiqua.ttf", 35);
  lg.setFont(font);
end
function won:draw()
  lg.setColor(0,0,0);
  lg.print("Back On Earth! ", lg.getWidth()/2-155, lg.getHeight()/6);
  lg.print("Score:  " .. math.floor(player.score), lg.getWidth()/2-135, lg.getHeight()/6*2); 
  lg.print("ElHurons: " .. collidedTimes, lg.getWidth()/2-135, lg.getHeight()/6*3);
  lg.print("(E) to say good-bye", lg.getWidth()/2-155, lg.getHeight()/6*4);
end
function won:update(dt)
end
function won:keypressed(key)
  if key == 'e' then love.event.push('quit'); end
end
