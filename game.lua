-- game.lua

game = gamestate.new();

function game:init()
  player:init();
  elhuron:init();
  tiles:init(); --generate tiles 
  dead:init();
  won:init();
  ingameMenu_init();
end
function game:draw()
  tiles:draw();
  elhuron:draw(); 
  player:draw();
  player:draw_score();
  if collidedTimes == maxElHurons then won:draw(); end
  if ingameMenuOpen then ingameMenu_draw(); end 
  if not player.alive then dead:draw(); end
end
function game:update(dt)
  if not ingameMenuOpen then
      player:update(dt);
      elhuron:update(dt);
      tiles:update(dt); 
      tiles:collide(dt);
  end
end
function game:keypressed(key)
  player:keypressed(key);
  if not player.alive then dead:keypressed(key); end
  if collidedTimes == maxElHurons then won:keypressed(key); end
end
function game:keyreleased(key)
  ingameMenu_keyreleased(key);  
end
function game:focus(f)
  ingameMenu_focus(f);
end
