-- intro.lua 

intro = gamestate.new();
local introText, lg, la = { 'Gaichu In Need', 'Ver. 0.1' }, love.graphics, love.audio;
local spock, spockRot, spockScaleX, spockScaleY, rotating =  lg.newImage("assets/spock.png"), 0,  1.5, 1.5, false;
local timer, timerSpeed, timerStart = 3, 1, 0;
local dRot = math.pi/4; -- spock image rotation after timer/2 reached 
local introSpinSound = la.newSource("sfx/Batman_Logo_Spin.ogg");

function intro:init()
  local font = lg.newFont("fonts/PixAntiqua.ttf", 35); 
  lg.setFont(font);
  introSpinSound:play();
  introSpinSound:setVolume(.15);
  introSpinSound:setLooping(false);
end
function intro:draw()
  lg.setColor(0,0,0);
  for i=1,#introText do
    lg.print(introText[i], (lg.getWidth()/2-125*(1/i)), lg.getHeight()/6*i+50);
  end
  lg.setColor(255,255,255);
  if not rotating then
    lg.draw(spock, lg.getWidth()/2-45, lg.getHeight()/2+35, spockRot, spockScaleX, spockScaleY);
  elseif rotating then
    lg.draw(spock, lg.getWidth()/2-15, lg.getHeight()/2+35, dRot, spockScaleX, spockScaleY);
    lg.setColor(255, 0, 0);
    lg.print("Wormhole In Sight! Prepare Yourselves . . . " .. timer - math.floor(timerStart), 25, lg.getHeight()/2+225);
    lg.print("Controls: A/D or left/right", lg.getWidth()/2-100, lg.getHeight()/2+300);
    lg.setColor(255, 255, 255);
  end
end
function intro:update(dt)
  timerStart = timerStart + (timerSpeed*dt);
  if ((timerStart >= 0) and not (timerStart >= timer+0.99)) then 
    rotating = true;
    dRot = dRot + 0.1;
  elseif timerStart >= timer+0.99 then -- for nice looking countdown with floor 
   gamestate.switch(game);
  end
end
function intro:keypressed(key)
  if key == 'return' then
    gamestate.switch(game);
    introSpinSound:stop(); end 
end
