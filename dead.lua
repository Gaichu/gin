-- dead.lua this stuff's under construction

dead = gamestate.new();

local deadText, lg, le = { 'Oh nooo!\nYour capsule crashed', "Score: " .. tostring(player.score), '(A)gain', '(E)xit' }, love.graphics, love.event;

function dead:init()
  local font = lg.newFont("fonts/PixAntiqua.ttf", 35);
  lg.setFont(font);
end
function dead:draw()
  if not player.alive then 
    lg.setColor(0,0,0);
    for i=1,#deadText do
      lg.print(deadText[i], lg.getWidth()/2-155*(1/i), lg.getHeight()/6*i )
    lg.setColor(255, 255, 255)
    end
  end
end
function dead:keypressed(key)  
  if key == 'a' then
    player.alive = true;
    for i = 1,#deadText do table.remove(deadText); end
    gamestate.switch(intro);
  elseif key == 'e' then 
    le.push('quit');
  end
end
