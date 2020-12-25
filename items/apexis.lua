local L = LibStub("AceLocale-3.0"):GetLocale("RPManagerItems")

function RPManagerItems:doRegisterApexis()
  return {
    id = "Apexis",
    name = L["apexis"],
    icon = "interface/icons/inv_misc_cat_trinket05",
    quality = "3",
    left = "",
    right = "",
    desc = "",
    comment = L["apexisComment"],
    usage = L["apexisUsage"],
  }
end

function RPManagerItems:getCustomizationApexis()
  return ""
end

function RPManagerItems:getCodeApexis()
  local code =
          "local AP_BUTTONS={{'567002',0,0,1},{'565374',1,0,0},{'567142',0,1,0},{'566196',1,1,0}}\n" ..
          "local AP_UNDEF = 0\n" ..
          "local AP_ADDING = 1\n" ..
          "local AP_PLAYING = 2\n" ..
          "local AP_WAITING = 3\n" ..
          "local AP_MATERIAL='wood'\n" ..
          "-- AP_MATERIAL='darkwood'\n" ..
          "--AP_MATERIAL='ivory'\n" ..
          "\n" ..
          "local timeCounter = 0\n" ..
          "local currentRound = 0\n" ..
          "local currentNote = 0\n" ..
          "local currentMode = AP_UNDEF\n" ..
          "local silentMode = true\n" ..
          "local noteList = {}\n" ..
          "local buttonList = {}\n" ..
          "local highlightBtn = nil\n" ..
          "local highlightCounter = 0\n" ..
          "\n" ..
          "local function printMsg(msg)\n" ..
          "  local txt = '|| Klang der Apexis sagt: '..msg\n" ..
          "  if silentMode then\n" ..
          "    if IsInRaid() then\n" ..
          "      SendChatMessage(txt, 'RAID')\n" ..
          "    elseif IsInGroup() then\n" ..
          "      SendChatMessage(txt, 'PARTY')\n" ..
          "    else\n" ..
          "      print(msg)\n" ..
          "    end\n" ..
          "  else\n" ..
          "    SendChatMessage(txt, 'EMOTE')\n" ..
          "  end\n" ..
          "end\n" ..
          "\n" ..
          "local function changeMode(mode)\n" ..
          "  currentMode = mode\n" ..
          "  timeCounter = 0\n" ..
          "end\n" ..
          "\n" ..
          "local function gameLost(msg)\n" ..
          "  changeMode(AP_UNDEF)\n" ..
          "  printMsg(string.format('"..L["apexisDefeat"].."', currentRound, msg))\n" ..
          "end\n" ..
          "\n" ..
          "local function onClose()\n" ..
          "  if currentMode > AP_UNDEF then gameLost('"..L["apexisReasonGiveUp"].."') end\n" ..
          "  AP_BOX:Hide()\n" ..
          "  AP_BOX=nil\n" ..
          "end\n" ..
          "\n" ..
          "local function addNote()\n" ..
          "  changeMode(AP_UNDEF)\n" ..
          "  currentRound=currentRound+1\n" ..
          "  noteList[currentRound]=buttonList[math.random(#AP_BUTTONS)]\n" ..
          "  currentNote=1\n" ..
          "  changeMode(AP_PLAYING)\n" ..
          "end\n"
  code = code .. "\n" ..
          "local function playSound(btn)\n" ..
          "  local f=btn.back\n" ..
          "  f.tex:SetColorTexture(f.r,f.g,f.b,1)\n" ..
          "  highlightBtn = btn\n" ..
          "  highlightCounter = 0\n" ..
          "  RPMUtil.playSound(btn.color)\n" ..
          "end\n" ..
          "\n" ..
          "local function playNote()\n" ..
          "  playSound(noteList[currentNote])\n" ..
          "  timeCounter=0\n" ..
          "  currentNote=currentNote+1\n" ..
          "  if currentNote>currentRound then\n" ..
          "    changeMode(AP_WAITING)\n" ..
          "    currentNote=0\n" ..
          "    return\n" ..
          "  end\n" ..
          "end\n" ..
          "\n" ..
          "local function setOutput()\n" ..
          "  silentMode=not silentMode\n" ..
          "  if silentMode then\n" ..
          "    print('"..L["apexisOutput1"].."')\n" ..
          "  else\n" ..
          "    print('"..L["apexisOutput2"].."')\n" ..
          "  end\n" ..
          "end\n" ..
          "\n" ..
          "local function onUpdate(self,elapsed)\n" ..
          "  timeCounter=timeCounter+elapsed\n" ..
          "  highlightCounter=highlightCounter+elapsed\n" ..
          "  \n" ..
          "  if currentMode==AP_ADDING then\n" ..
          "    addNote()\n" ..
          "  elseif currentMode==AP_PLAYING and timeCounter>=.5 then\n" ..
          "    playNote()\n" ..
          "  elseif currentMode==AP_WAITING and timeCounter>=2+(currentRound*.75) then\n" ..
          "    if currentNote==currentRound then\n" ..
          "      printMsg(string.format('"..L["apexisSuccess"].."', currentRound))\n" ..
          "      changeMode(AP_ADDING)\n" ..
          "    else gameLost('"..L["apexisReasonTime"].."') end\n" ..
          "  end\n" ..
          "  \n" ..
          "  if highlightBtn ~= nil and highlightCounter >= 0.4 then\n" ..
          "    local f=highlightBtn.back\n" ..
          "    f.tex:SetColorTexture(f.r/2,f.g/2,f.b/2,1)\n" ..
          "    highlightBtn = nil\n" ..
          "  end\n" ..
          "end\n" ..
          "\n" ..
          "local function onButton(btn)\n" ..
          "  if currentMode~=AP_WAITING then return end\n" ..
          "  playSound(btn)\n" ..
          "  currentNote=currentNote+1\n" ..
          "  if noteList[currentNote] == nil or btn.color~=noteList[currentNote].color then gameLost('"..L["apexisReasonError"].."') end\n" ..
          "end\n" ..
          "\n" ..
          "local function startNewGame()\n" ..
          "  if currentMode>AP_UNDEF then gameLost('"..L["apexisReasonGiveUp"].."') end\n" ..
          "  currentRound=0\n" ..
          "  noteList={}\n" ..
          "  changeMode(AP_ADDING)\n" ..
          "end\n"
  code = code .. "\n" ..
          "local function drawFrame(x,y,w,h,lev,tex,p)\n" ..
          "  local f=CreateFrame('Frame',nil,p)\n" ..
          "  f:SetPoint('CENTER',p,'CENTER',x,y)\n" ..
          "  f:SetSize(w,h)\n" ..
          "  f:SetFrameLevel(lev)\n" ..
          "  local t=f:CreateTexture(nil,'BACKGROUND')\n" ..
          "  t:SetTexture(tex)\n" ..
          "  t:SetAllPoints()\n" ..
          "  f.tex=t\n" ..
          "  return f\n" ..
          "end\n" ..
          "\n" ..
          "local function drawButton(x,y,w,h,lev,p)\n" ..
          "  local btn=CreateFrame('Button',''..x..y,p,'UICheckButtonTemplate')\n" ..
          "  btn:SetPoint('CENTER',p,'CENTER',x,y)\n" ..
          "  btn:SetSize(w,h)\n" ..
          "  btn:SetFrameLevel(lev)\n" ..
          "  return btn\n" ..
          "end\n" ..
          "\n" ..
          "local function showHelp()\n" ..
          "  if AP_HELP ~= nil then\n" ..
          "    AP_HELP:Hide()\n" ..
          "    AP_HELP=nil\n" ..
          "    return\n" ..
          "  end\n" ..
          "  \n" ..
          "  local f=drawFrame(0,0,512,384,30,nil,UIParent)\n" ..
          "  AP_HELP=f\n" ..
          "  local path='Interface/OPTIONSFRAME/UIOptionsFrame-'\n" ..
          "  drawFrame(-128,64,256,256,30,path..'TopLeft',f)\n" ..
          "  drawFrame(128,64,256,256,30,path..'TopRight',f)\n" ..
          "  drawFrame(-128,-128,256,128,30,path..'BottomLeft',f)\n" ..
          "  drawFrame(128,-128,256,128,30,path..'BottomRight',f)\n" ..
          "\n" ..
          "  local cls=CreateFrame('Button',nil,f,'UIPanelCloseButton')\n" ..
          "  cls:SetPoint('TOPRIGHT', 5, 5)\n" ..
          "  cls:SetScript('OnMouseUp',function() AP_HELP:Hide();AP_HELP=nil end)\n" ..
          "\n" ..
          "  local scf=CreateFrame('ScrollFrame','s'..time(),f,'UIPanelScrollFrameTemplate')\n" ..
          "  scf:SetPoint('TOPLEFT',f,'TOPLEFT',10,-35)\n" ..
          "  scf:SetPoint('BOTTOMRIGHT',f,'BOTTOMRIGHT',-25,15)\n" ..
          "\n" ..
          "  local h=CreateFrame('SimpleHTML',nil,f)\n" ..
          "  scf:SetScrollChild(h)\n" ..
          "  h:SetSize(475,310)\n" ..
          "  h:SetPoint('CENTER',f,'CENTER',0,0)\n" ..
          "  h:SetFrameLevel(35)\n" ..
          "  h:SetFont('p','Fonts/ARIALN.ttf',18,nil)\n" ..
          "  h:SetTextColor('p',1.00,1.00,1.00,1)\n" ..
          "  h:SetFont('h1','Fonts/FRIZQT__.ttf',23,nil)\n" ..
          "  h:SetTextColor('h1',.7,.7,1,1)\n" ..
          "  h:SetFont('h2','Fonts/FRIZQT__.ttf',23,nil)\n" ..
          "  h:SetTextColor('h2',1,.84,0,1)\n" ..
          "  h:SetFont('h3','Fonts/ARIALN.ttf',23,nil)\n" ..
          "  -- h:SetTextColor('h3',0.30,0.30,0.30,1)\n" ..
          "  h:SetTextColor('h3',1.00,1.00,1.00,1)\n" ..
          "\n" ..
          "  local s = ''\n"
  for i = 1,7 do
    code = code .. "s = s .. '" .. L["apexisHelp"..i] .. "'\n"
  end
  code = code .. "  h:SetText(s)\n" ..
          "end\n" ..
          "\n" ..
          "local function buildCntButtons()\n" ..
          "  local btn=CreateFrame('Button',''..GetTime(),AP_BOX,'UIPanelButtonTemplate')\n" ..
          "  btn:SetPoint('BOTTOMLEFT',AP_BOX,'BOTTOMLEFT',238,28)\n" ..
          "  btn:SetSize(40,40)\n" ..
          "  btn:SetScript('OnMouseUp',startNewGame)\n" ..
          "\n" ..
          "  local mBtn=CreateFrame('Button',''..GetTime(),AP_BOX)\n" ..
          "  mBtn:SetPoint('TOPRIGHT',-39,6)\n" ..
          "  mBtn:SetSize(40,40)\n" ..
          "  mBtn:SetScript('OnMouseUp',setOutput)\n" ..
          "  mBtn:SetNormalTexture('Interface/BUTTONS/CancelButton-Up')\n" ..
          "  mBtn:SetHighlightTexture('Interface/BUTTONS/CancelButton-Highlight')\n" ..
          "  mBtn:SetPushedTexture('Interface/BUTTONS/CancelButton-Down')\n" ..
          "\n" ..
          "  local b=CreateFrame('Button',nil,AP_BOX,'UIPanelButtonTemplate')\n" ..
          "  b:SetText('?')\n" ..
          "  b:SetPoint('CENTER',AP_BOX,'CENTER',113,138)\n" ..
          "  b:SetSize(20,20)\n" ..
          "  b:SetScript('OnClick',showHelp)\n" ..
          "  \n" ..
          "  local cBtn=CreateFrame('Button','close',AP_BOX,'UIPanelCloseButton')\n" ..
          "  cBtn:SetPoint('TOPRIGHT',0,4)\n" ..
          "  cBtn:SetScript('OnMouseUp',onClose)\n" ..
          "end\n" ..
          "\n" ..
          "local function drawMain()\n" ..
          "  AP_BOX=drawFrame(0,0,300,300,12,nil,UIParent)\n" ..
          "  AP_BOX:SetClampedToScreen(true)\n" ..
          "  AP_BOX:SetMovable(true)\n" ..
          "  AP_BOX:EnableMouse(true)\n" ..
          "  AP_BOX:RegisterForDrag('LeftButton','RightButton')\n" ..
          "  AP_BOX:SetScript('OnDragStart',function(s,b) AP_BOX:StartMoving() end)\n" ..
          "  AP_BOX:SetScript('OnDragStop',function(s,b) AP_BOX:StopMovingOrSizing() end)\n" ..
          "  AP_BOX:SetScript('OnUpdate',onUpdate)\n" ..
          "\n" ..
          "  local f=drawFrame(0,0,300,300,10,'243028',AP_BOX)\n" ..
          "  \n" ..
          "  if AP_MATERIAL=='ivory' then\n" ..
          "    AP_BOX.tex:SetDesaturated(true)\n" ..
          "    AP_BOX.tex:SetColorTexture(1,1,.94,.65)\n" ..
          "  elseif AP_MATERIAL=='darkwood' then\n" ..
          "    f.tex:SetVertexColor(.3,.18,.15)\n" ..
          "  end  \n" ..
          "  \n" ..
          "  for z=1,2 do\n" ..
          "    for s=1,2 do\n" ..
          "      local i=s+((z-1)*2)\n" ..
          "      local bck=drawFrame((-1)^s*50,(-1)^z*50,58,58,15,nil,f)\n" ..
          "      bck.r=AP_BUTTONS[i][2]\n" ..
          "      bck.g=AP_BUTTONS[i][3]\n" ..
          "      bck.b=AP_BUTTONS[i][4]\n" ..
          "      bck.tex:SetColorTexture(bck.r/2,bck.g/2,bck.b/2,1)\n" ..
          "\n" ..
          "      local btn=drawButton((-1)^s*50,(-1)^z*50,100,100,20,f)\n" ..
          "      btn:SetScript('OnMouseUp',function(self,_) onButton(self) end)\n" ..
          "      btn.color=AP_BUTTONS[i][1]\n" ..
          "      btn.back=bck\n" ..
          "      buttonList[#buttonList+1]=btn\n" ..
          "      btn.id=#buttonList\n" ..
          "    end\n" ..
          "  end\n" ..
          "\n" ..
          "  buildCntButtons()\n" ..
          "end\n" ..
          "\n" ..
          "if AP_BOX then\n" ..
          "  onClose()\n" ..
          "else\n" ..
          "  drawMain()\n" ..
          "  setOutput()\n" ..
          "end\n"
  return code
end
