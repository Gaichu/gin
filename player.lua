-- player.lua (g in space capsule)

local class = require 'libraries/class';

player = class:new();
local lg = love.graphics;

function player:init()
  self.img = lg.newImage("assets/capsule1.png"); 
  self.x, self.y, self.w, self.h = lg.getWidth()/2, 0, self.img:getWidth(), self.img:getHeight();
  self.speed, self.gravity, self.vx = 200, 50,  0;
  self.score, self.gain = 0, 0.5; -- gain defines the amount of score gained (depending on rnd)
  self.alive, died = true, 0;
  self.rot, self.scaleX, self.scaleY = 0, 1, 1;
  
  self.anim = self.img
  self.hold = {} -- hold anim keypairs
  self.aTimer, self.aTStart = 1, 0;
  for i=1,2 do self.hold[i] = lg.newImage("assets/capsule" .. i .. ".png"); end
end
function player:draw()
  lg.draw(self.anim, self.x, self.y, self.rot, self.scaleX, self.scaleY);
end
function player:draw_score()
  lg.print("Score: " .. math.floor(self.score), lg.getWidth()/6-125, lg.getHeight()/2);
end
function player:update(dt)
  -- fire anim
  self.anim = self.hold[self.aTimer];

  local fwdBound = .25;
  if self.aTStart < fwdBound then
    self.aTStart = self.aTStart + dt;
  elseif self.aTStart >= fwdBound then
    self.aTimer = self.aTimer + 1;
    self.aTStart = 0;
  end
  if self.aTimer > 2 then self.aTimer = 1; end -- set img back to start anim again
  
  self.y = self.y + self.gravity*dt; -- grav pulls player down (middle of display height)
  if self.y >= lg.getHeight()/2-125 then self.y = lg.getHeight()/2-125; end
  -- feeling is smoother and game does not become boring so fast..
  self.x = self.x + (self.vx*dt); -- vx becomes +/-speed if keys pressed
  if self.x >= lg.getWidth()-self.w then self.x = lg.getWidth()-self.w; 
  elseif self.x <= 0 then self.x = 0; end

  -- gain score
  local rnd = math.random(0,2)
  if rnd % 2 == 0 then
    self.score = self.score + .1;
  end
end
function player:keypressed(key)
   if key == 'a' or key == 'left' then self.vx = -self.speed; 
   elseif key == 'd' or key == 'right' then self.vx = self.speed;  end
end
function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end
