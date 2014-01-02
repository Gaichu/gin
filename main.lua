-- main.lua

-- data pool 
require 'earth';
require 'player';
require 'map';
require 'ingameMenu'; 
gamestate = require 'libraries/gamestate';
require 'intro';
require 'dead';
require 'won'; 
require 'game'; --last one

local lg,lw  = love.graphics,love.window;
function love.load()
  lg.setBackgroundColor(185, 211, 238);
  gamestate.registerEvents();
  gamestate.switch(intro);
end
