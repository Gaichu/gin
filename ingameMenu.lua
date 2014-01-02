--ingameMenu.lua

local lg = love.graphics;
local pauseText = {}

function ingameMenu_init()
  local font = lg.newFont("fonts/PixAntiqua.ttf", 25);
  lg.setFont(font);
  local ingameMenuOpen = false;
  pauseText.show = [[ un(P)ause or (E)xit ]]
end
function ingameMenu_focus(f)
  if not f then ingameMenuOpen = true;
  else ingameMenuOpen = false; end
end
function ingameMenu_keyreleased(key)
  if key == 'p' then
    ingameMenuOpen = not ingameMenuOpen;
  elseif key == 'e' and ingameMenuOpen then -- prevent from using 'e' to exit when not pausing  
    love.event.push('quit'); 
  end -- quit the game
end
function ingameMenu_draw()
  lg.setColor(255,255,255);
  if ingameMenuOpen then lg.print(pauseText.show, lg.getWidth()/2-125, 0); end
end

