-- earth.lua (collect little elhurons to gain more points)

local lg = love.graphics;

elhuron = {};
local img = lg.newImage("assets/earth.png");

function createElHuron(x, y) -- this is kind of disturbing
    table.insert(elhuron, { x = x, y = y,
      w = img:getWidth(),  h =  img:getHeight(), rotate = 0, scaleX = .175,
        scaleY = .175 }); 
end
function elhuron:init()
  maxElHurons, collidedTimes = 10, 0;
  local diff = 1500;
  for i=1,maxElHurons do
    createElHuron(lg.getHeight()/2-50, diff*i);
  end
end
function elhuron:spin(dt)
  for i,v in ipairs(elhuron) do 
    v.rotate = v.rotate + math.rad(math.pi/3);
    if i == maxElHurons then v.scaleX, v.scaleY = 1, 1; end -- for father ElHuron
  end
end
function elhuron:collision(dt) -- you have to collide with all ElHurons to win
  for i,v in ipairs(elhuron) do
    if CheckCollision(player.x, player.y, player.w, player.h, v.x, v.y, v.w*v.scaleX, v.h*v.scaleY) then  
      table.remove(elhuron, i);
       collidedTimes = collidedTimes + 1;
      if collidedTimes < maxElHurons then  
        player.score = player.score + 100;
      elseif collidedTimes == maxElHurons then  
       player.score = player.score + 500;
       gamestate.switch(won);
      end
    end
  end
  print(collidedTimes);
end
function elhuron:update(dt)
  for i,v in ipairs(elhuron) do
    v.y = v.y - 100*dt; -- elhurons move against tiles so it looks like they would stand on map
  end
  elhuron:collision(dt);
  elhuron:spin(dt);
end
function elhuron:draw()
  for i,v in ipairs(elhuron) do
     lg.draw(img, v.x, v.y, v.rotate, v.scaleX, v.scaleY, v.w/2, v.h/2);
  end
end
