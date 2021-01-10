local L = LibStub("AceLocale-3.0"):GetLocale("RPManagerItems")

function RPManagerItems:doRegisterAirgun()
  return {
    id = "Airgun",
    name = L["airgun"],
    icon = "interface/icons/inv_weapon_rifle_04",
    quality = "1",
    left = L["distance"],
    right = L["rifle"],
    desc = L["airgunDesc"],
    comment = L["airgunComment"],
    usage = L["airgunUsage"],
  }
end

function RPManagerItems:getCustomizationAirgun()
  return ""
end

function RPManagerItems:getCodeAirgun()
  local code = "local BO_ACTION_TIME=2\n" ..
          "local BO_NUM_ROUNDS=3\n" ..
          "local BO_MAX_SHOTS=5\n" ..
          "local BO_FILES={\"01\",\"02\",\"03\"}\n" ..
          "local BO_ACTIONS={\n" ..
          "  ['"..L["airgunCock"].."']={10,2},\n" ..
          "  ['"..L["airgunAim"].."']={9,2},\n" ..
          "  ['"..L["airgunWarp"].."']={9,2},\n" ..
          "  ['"..L["airgunBreath"].."']={7,1},\n" ..
          "  ['"..L["airgunDistance"].."']={7,1},\n" ..
          "  ['"..L["airgunStand"].."']={5,1},\n" ..
          "  ['"..L["airgunBlend"].."']={5,1},\n" ..
          "  ['"..L["airgunClose"].."']={0,0},\n" ..
          "  ['"..L["airgunLight"].."']={0,0}\n" ..
          "}\n" ..
          "local btnLeft, btnRight, btnStart, targetFrm, helpFrm, actionSet\n" ..
          "local hitMod, points, isStarted, numShots, timer, currentRound\n" ..
          "local start, press\n" ..
          "local function toggleControls()\n" ..
          "  if isStarted then\n" ..
          "    btnLeft:Show()\n" ..
          "    btnRight:Show()\n" ..
          "    btnStart:Hide()\n" ..
          "  else\n" ..
          "    btnLeft:Hide()\n" ..
          "    btnRight:Hide()\n" ..
          "    btnStart:Show()\n" ..
          "  end\n" ..
          "end\n" ..
          "local function drawButton(x,y,w,h,p,txt,func)\n" ..
          "  local b=CreateFrame(\"Button\",nil,p,\"UIPanelButtonTemplate\")\n" ..
          "  b:SetText(txt)\n" ..
          "  b:SetPoint(\"CENTER\",p,\"CENTER\",x,y)\n" ..
          "  b:SetSize(w,h)\n" ..
          "  b:SetScript(\"OnClick\",func)\n" ..
          "  return b\n" ..
          "end\n" ..
          "local function drawToken(x,y,w,h,l,p,tex)\n" ..
          "  local f=CreateFrame(\"Frame\",nil,p)\n" ..
          "  local t=f:CreateTexture(nil,\"ARTWORK\")\n" ..
          "  t:SetAllPoints()\n" ..
          "  t:SetTexture(tex)\n" ..
          "  f:SetPoint(\"CENTER\",p,\"CENTER\",x,y)\n" ..
          "  f:SetSize(w,h)\n" ..
          "  f:SetFrameLevel(l)\n" ..
          "  f.tex=t\n" ..
          "  return f\n" ..
          "end\n" ..
          "local function drawHole(x,y)\n" ..
          "  local t = drawToken(x,y,10,10,120,targetFrm,\"INTERFACE/GLUES/Models/UI_MAINMENU_BURNINGCRUSADE/HELLFIREPLANET01\")\n" ..
          "  t.tex:SetDesaturated(true)\n" ..
          "  targetFrm.hits[#targetFrm.hits+1]=t\n" ..
          "end\n" ..
          "local function drawTarget()\n" ..
          "  for i=1,5 do\n" ..
          "    local f=drawToken(0,50,i*900/16,i*900/16,120-i,targetFrm,\"Interface/CHARACTERFRAME/TempPortraitAlphaMask\")\n" ..
          "    if i==1 then f.tex:SetVertexColor(0,0,0,1)\n" ..
          "    elseif i==2 or i==4 then f.tex:SetVertexColor(1,1,1,1)\n" ..
          "    else f.tex:SetVertexColor(1,0,0,1) end\n" ..
          "  end\n" ..
          "end\n" ..
          "local function drawControls()\n" ..
          "  btnStart = drawButton(0,-160,75,50,targetFrm,'"..L["airgunStart"].."', start)\n" ..
          "  btnLeft = drawButton(-75,-150,150,100,targetFrm,\"\",press)\n" ..
          "  btnRight = drawButton(75,-150,150,100,targetFrm,\"\",press)\n" ..
          "  toggleControls()\n" ..
          "end\n" ..
          "local function openHelp()\n" ..
          "  local f=drawToken(0,0,512,384,130,UIParent,nil)\n" ..
          "  helpFrm=f\n" ..
          "  local path=\"Interface/OPTIONSFRAME/UIOptionsFrame-\"\n" ..
          "  drawToken(-128,64,256,256,130,f,path..\"TopLeft\")\n" ..
          "  drawToken(128,64,256,256,130,f,path..\"TopRight\")\n" ..
          "  drawToken(-128,-128,256,128,130,f,path..\"BottomLeft\")\n" ..
          "  drawToken(128,-128,256,128,130,f,path..\"BottomRight\")\n" ..
          "\n" ..
          "  local cls=CreateFrame(\"Button\",nil,f,\"UIPanelCloseButton\")\n" ..
          "  cls:SetPoint(\"TOPRIGHT\", 5, 5)\n" ..
          "  cls:SetScript(\"OnMouseUp\",function() helpFrm:Hide();helpFrm=nil end)\n" ..
          "\n" ..
          "  local scf=CreateFrame(\"ScrollFrame\",\"s\"..time(),f,\"UIPanelScrollFrameTemplate\")\n" ..
          "  scf:SetPoint(\"TOPLEFT\",f,\"TOPLEFT\",10,-35)\n" ..
          "  scf:SetPoint(\"BOTTOMRIGHT\",f,\"BOTTOMRIGHT\",-25,15)\n" ..
          "\n" ..
          "  local h=CreateFrame(\"SimpleHTML\",nil,f)\n" ..
          "  scf:SetScrollChild(h)\n" ..
          "  h:SetSize(475,310)\n" ..
          "  h:SetPoint(\"CENTER\",f,\"CENTER\",0,0)\n" ..
          "  h:SetFrameLevel(135)\n" ..
          "  h:SetFont('p',RPMFont.FRITZ,18,nil)\n" ..
          "  h:SetTextColor('p',1.00,1.00,1.00,1)\n" ..
          "  h:SetFont('h1',RPMFont.FRITZ,23,nil)\n" ..
          "  h:SetTextColor('h1',.7,.7,1,1)\n" ..
          "  h:SetFont('h2',RPMFont.FRITZ,23,nil)\n" ..
          "  h:SetTextColor('h2',1,.84,0,1)\n" ..
          "  h:SetFont('h3',RPMFont.FRITZ,23,nil)\n" ..
          "  h:SetTextColor('h3',1.00,1.00,1.00,1)\n" ..
          "  local s = ''\n"
  for i = 1,20 do
    code = code .. "s = s .. \"" .. L["airgunHelp"..i] .. "\"\n"
  end
  code = code .. "  h:SetText(s)\n" ..
          "end\n" ..
          "local function getCode()\n" ..
          "  return \"local function close()\\\n" ..
          "for i=1,#BO_MAIN.hits do\\\n" ..
          "BO_MAIN.hits[i]:Hide();BO_MAIN.hits[i]=nil\\\n" ..
          "end\\\n" ..
          "BO_MAIN:Hide();BO_MAIN=nil\\\n" ..
          "end\\\n" ..
          "local function drawToken(x,y,s,l,p,tex)\\\n" ..
          "local f=CreateFrame('Frame',nil,p)\\\n" ..
          "local t=f:CreateTexture(nil,'ARTWORK')\\\n" ..
          "t:SetTexture(tex)\\\n" ..
          "t:SetAllPoints()\\\n" ..
          "f:SetPoint('CENTER',p,'CENTER',x,y)\\\n" ..
          "f:SetSize(s,s)\\\n" ..
          "f:SetFrameLevel(l)\\\n" ..
          "f.tex=t\\\n" ..
          "return f\\\n" ..
          "end\\\n" ..
          "local function drawTarget()\\\n" ..
          "for i=1,5 do\\\n" ..
          "local f=drawToken(0,0,i*900/16,120-i,BO_MAIN,'Interface/CHARACTERFRAME/TempPortraitAlphaMask')\\\n" ..
          "if i==1 then f.tex:SetVertexColor(0,0,0,1)\\\n" ..
          "elseif i%2==0 then f.tex:SetVertexColor(1,1,1,1)\\\n" ..
          "else f.tex:SetVertexColor(1,0,0,1) end\\\n" ..
          "end\\\n" ..
          "end\\\n" ..
          "local function drawHole(x,y)\\\n" ..
          "local t=drawToken(x,y-50,10,120,BO_MAIN,'INTERFACE/GLUES/Models/UI_MAINMENU_BURNINGCRUSADE/HELLFIREPLANET01')\\\n" ..
          "t.tex:SetDesaturated(true)\\\n" ..
          "BO_MAIN.hits[#BO_MAIN.hits+1]=t\\\n" ..
          "end\\\n" ..
          "if BO_MAIN then close();return end\\\n" ..
          "BO_MAIN=drawToken(0,50,300,110,UIParent,'126805')\\\n" ..
          "BO_MAIN.hits={}\\\n" ..
          "local cls=CreateFrame('Button',nil,BO_MAIN,'UIPanelCloseButton')\\\n" ..
          "cls:SetPoint('TOPRIGHT',0,0)\\\n" ..
          "cls:SetScript('OnMouseUp',close)\\\n" ..
          "cls:SetFrameLevel(120)\\\n" ..
          "drawTarget()\\\n" ..
          "\"\n" ..
          "end\n"
  code = code ..
          "local function export()\n" ..
          "  local custom = 'local holes = { '\n" ..
          "  for i=1,#targetFrm.hits do\n" ..
          "    local _,_,_,x,y=targetFrm.hits[i]:GetPoint(1)\n" ..
          "     custom = custom .. '{ ' .. string.format('%.1f',x) .. ', ' .. string.format(\"%.1f\",y) .. '},'\n" ..
          "  end\n" ..
          "  custom = custom .. '}'\n" ..
          "  local code = getCode()\n" ..
          "  code = code..'for i = 1, #holes do'\n" ..
          "  code = code..'  drawHole(holes[i][1], holes[i][2])'\n" ..
          "  code = code..'end'\n" ..
          "  local name = ''\n" ..
          "  if numShots == 1 then\n" ..
          "    name = string.format('"..L["airgunTargetNameSng"].."', points)\n"..
          "  else\n" ..
          "    name = string.format('"..L["airgunTargetNamePlu"].."', points, numShots)\n"..
          "  end\n" ..
          "  local data = {\n" ..
          "    name = name,\n" ..
          "    icon = \"interface/icons/Ability_Hunter_FocusedAim\",\n" ..
          "    quality = \"1\",\n" ..
          "    left = \"\",\n" ..
          "    right = \"\",\n" ..
          "    desc = \"\",\n" ..
          "    comment = \"\",\n" ..
          "    usage = '"..L["airgunTargetUsage"].."',\n" ..
          "  }\n" ..
          "  local item, _ = RPMTemplate.setNewItem(RPManager.ITEM_TYPE_SCRIPT, data, RPMCharacterDB)\n" ..
          "  item.customization = custom\n" ..
          "  item.script = code\n" ..
          "  RPMBag.updateBag()\n" ..
          "end\n" ..
          "local function onClose()\n" ..
          "  if #targetFrm.hits > 0 then\n" ..
          "    export()\n" ..
          "  end\n" ..
          "  btnLeft:Hide()\n" ..
          "  btnLeft=nil\n" ..
          "  btnRight:Hide()\n" ..
          "  btnRight=nil\n" ..
          "  btnStart:Hide()\n" ..
          "  btnStart=nil\n" ..
          "  targetFrm:Hide()\n" ..
          "  targetFrm=nil\n" ..
          "end\n" ..
          "local function output(s)\n" ..
          "  local msg = '"..L["airgunEmoteB"].."'\n" ..
          "  local pts = 10\n" ..
          "  if s>250 then msg='"..L["airgunEmoteF"].."';pts=0\n" ..
          "  elseif s>200 then msg='"..L["airgunEmote4"].."';pts=2\n" ..
          "  elseif s>150 then msg='"..L["airgunEmote3"].."';pts=3\n" ..
          "  elseif s>100 then msg='"..L["airgunEmote2"].."';pts=4\n" ..
          "  elseif s>50 then msg='"..L["airgunEmote1"].."';pts=5 end\n" ..
          "  SendChatMessage(msg, \"EMOTE\")\n" ..
          "  points = points+pts\n" ..
          "end\n" ..
          "local function rotate(y)\n" ..
          "  local a = math.random()*2*math.pi\n" ..
          "  return -y*math.sin(a), y*math.cos(a)\n" ..
          "end\n" ..
          "local function sound(s,a)\n" ..
          "  RPMUtil.playSound(string.format(\"Sound/Item/Weapons/Gun/\"..s..\"%s.ogg\",a[math.random(3)]))\n" ..
          "end\n" ..
          "local function shoot(pressed)\n" ..
          "  if not pressed and currentRound == 1 then\n" ..
          "    hitMod = 0\n" ..
          "  end\n" ..
          "  isStarted=false\n" ..
          "  toggleControls()\n" ..
          "  numShots=numShots+1\n" ..
          "  sound(\"GunFire\", BO_FILES)\n" ..
          "  local s=275-(math.min(hitMod,5)*50)+math.random(-25,25)\n" ..
          "  local x,y=rotate(s*9/16)--Kreis ist 18x18 / Textur 32x32\n" ..
          "  drawHole(x,y+50)\n" ..
          "  output(s)\n" ..
          "  if numShots==BO_MAX_SHOTS then\n" ..
          "    local i = UnitSex(\"player\")\n" ..
          "    SendChatMessage('"..L["airgunEmoteEmpty"].."',\"EMOTE\")\n" ..
          "    onClose()\n" ..
          "  end\n" ..
          "end\n" ..
          "local function onUpdate(_, elapsed)\n" ..
          "  if isStarted and timer>0 then\n" ..
          "    timer=timer-elapsed\n" ..
          "    if timer<=0 then\n" ..
          "      shoot(false)\n" ..
          "    end\n" ..
          "  end\n" ..
          "end\n" ..
          "local function buildDeck()\n" ..
          "  actionSet = {}\n" ..
          "  for k, _ in pairs(BO_ACTIONS) do\n" ..
          "    actionSet[#actionSet+1] = k\n" ..
          "  end\n" ..
          "end\n" ..
          "local function play(num)\n" ..
          "  btnLeft:SetText(actionSet[num*2-1])\n" ..
          "  btnRight:SetText(actionSet[num*2])\n" ..
          "  timer=BO_ACTION_TIME\n" ..
          "  isStarted=true\n" ..
          "  toggleControls()\n" ..
          "  currentRound=num\n" ..
          "end\n" ..
          "local function shuffle()\n" ..
          "  for i=1,#actionSet do\n" ..
          "    local j=math.random(#actionSet)\n" ..
          "    local s=actionSet[i]\n" ..
          "    actionSet[i]=actionSet[j]\n" ..
          "    actionSet[j]=s\n" ..
          "  end\n" ..
          "end\n" ..
          "function press(self)\n" ..
          "  isStarted = false\n" ..
          "  local c1 = BO_ACTIONS[actionSet[currentRound*2-1]]\n" ..
          "  local c2 = BO_ACTIONS[actionSet[currentRound*2]]\n" ..
          "  if self==btnLeft and c1[1]>=c2[1] then\n" ..
          "    hitMod=hitMod+c1[2]\n" ..
          "  elseif self==btnRight and c2[1]>=c1[1] then\n" ..
          "    hitMod=hitMod+c2[2]\n" ..
          "  end\n" ..
          "  if currentRound == BO_NUM_ROUNDS then\n" ..
          "    shoot(true)\n" ..
          "  else\n" ..
          "    play(currentRound+1)\n" ..
          "  end\n" ..
          "end\n" ..
          "local function drawMain()\n" ..
          "  targetFrm=drawToken(0,50,300,400,110,UIParent,\"126805\")\n" ..
          "  targetFrm:SetScript(\"OnUpdate\", onUpdate)\n" ..
          "  targetFrm.hits={}\n" ..
          "  local cls=CreateFrame(\"Button\",nil,targetFrm,\"UIPanelCloseButton\")\n" ..
          "  cls:SetPoint(\"TOPRIGHT\",1,1)\n" ..
          "  cls:SetScript(\"OnMouseUp\", onClose)\n" ..
          "  drawButton(115,185,20,20,targetFrm, \"?\", openHelp)\n" ..
          "  drawTarget()\n" ..
          "  drawControls()\n" ..
          "end\n"
  code = code .. "function start()\n" ..
          "  hitMod = 0\n" ..
          "  sound(\"GunLoad\", BO_FILES)\n" ..
          "  shuffle()\n" ..
          "  play(1)\n" ..
          "end\n" ..
          "if targetFrm == nil then\n" ..
          "  isStarted=false\n" ..
          "  numShots=0\n" ..
          "  timer=0\n" ..
          "  points=0\n" ..
          "  buildDeck()\n" ..
          "  drawMain()\n" ..
          "  toggleControls()\n" ..
          "else\n" ..
          "  onClose()\n" ..
          "end"
  return code
end
