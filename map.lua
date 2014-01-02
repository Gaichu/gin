-- map.lua
-- this file uses Code from Destructive Realities great game "ftr" *-*

local class = require 'libraries/class';
tiles = class:new();
local lg = love.graphics;

function tiles:init()
  self.tiles = {}
  self.w, self.h = self.w, lg.getHeight()/25;
  -- for random width generation of tiles. at beginning one tile is 200px
  -- when maxWidth is reached the width of tiles on the max and vice versa with minWidth
  self.wControl, self.maxWidth, self.minWidth = 0, 5, -6;
  self.timer = 0;

  self.speed = -450 
end
function tiles:generateLeftBlock()
   leftBlock  = { x = 0, y = lg.getHeight(), w = 10*self.wControl+200, h = self.h }
   table.insert(self.tiles, leftBlock);
end
function tiles:generateRightBlock()
   rightBlock = { x = lg.getWidth() - (-20*self.wControl+200), y = lg.getHeight(), w = (-20*self.wControl+250), h = self.h } 
   table.insert(self.tiles, rightBlock);
end
function tiles:randomWidthValueGeneration()
  local rand = math.random(0,1) -- generate either 0 or 1
  if ((self.wControl  < self.maxWidth) and (self.wControl > self.minWidth))  then
    if rand == 0 then 
       self.wControl = self.wControl - 1
    elseif rand == 1 then
      self.wControl = self.wControl + 1
    end
  elseif self.wControl == self.minWidth and rand == 0 then
     self.wControl = self.wControl + 1
  elseif self.wControl == self.maxWidth and rand == 1 then
     self.wControl = self.wControl - 1
  end
end
function tiles:update(dt)
  tiles:generateLeftBlock();
  tiles:generateRightBlock();
  tiles:randomWidthValueGeneration(); -- each cycle a value to influence the width of new spawning blocks is generated
 
  for i,v in ipairs(self.tiles) do
     v.y = v.y + self.speed*dt;
	   if player.y - lg.getHeight()/2 > v.y then 
         table.remove(self.tiles, i);
     end
  end
end
function tiles:collide()
--[[ for i,v in ipairs(self.tiles) do
    if CheckCollision(player.x, player.y, player.w, player.h, v.x, v.y, v.w, v.h) then
      player.alive = false;
      gamestate.switch(dead);
    end
  end --]]
end
function tiles:draw()
  lg.setColor(0,0,0,255);
  for i,v in ipairs(self.tiles) do
    lg.rectangle('fill', v.x, v.y, v.w, v.h);
  end
  lg.setColor(255, 255, 255, 255);
end
