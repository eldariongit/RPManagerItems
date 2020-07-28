local L = LibStub("AceLocale-3.0"):GetLocale("RPManagerItems")

function RPManagerItems:doRegisterManaFlow()
  return {
    id = "ManaFlow",
    name = L["manaflow"],
    icon = "interface/icons/spell_arcane_arcane04",
    quality = "3",
    left = "",
    right = "",
    desc = L["manaflowDesc"],
    comment = L["manaflowComment"],
    usage = L["manaflowUsage"],
  }
end

function RPManagerItems:getCustomizationManaFlow()
  return ""
end

function RPManagerItems:getCodeManaFlow()
  local code = "MANA_COUNTER = 0\n" ..
          "GLOW_COUNTER = 0\n" ..
          "LEVEL_TIME = 0\n"..
          "local DUELL_KREIS_X,DUELL_KREIS_Y=4243,4514\n"..
          "local PREFIX = \"MANAFLUSS\"\n"..
          "local buttonStart,buttonStop\n"..
          "local gameMode = \"stop\"\n"..
          "local gameLevel = 0\n"..
          "local linkList = {}\n"..
          "local linkCandidates = {}\n"..
          "\n"..
          "local function msg(m)\n"..
          "  print(m)\n"..
          "end\n"..
          "local function send(msg)\n"..
          "  ChatThrottleLib:SendAddonMessage(\"ALERT\", PREFIX, msg, \"RAID\")\n"..
          "end\n"..
          "local function cmdCenter()\n"..
          "  DUELL_KREIS_Y,DUELL_KREIS_X = UnitPosition(\"player\")\n"..
          "  send(\"center:\"..DUELL_KREIS_X..\":\"..DUELL_KREIS_Y)\n"..
          "end\n"..
          "local function cmdHelp()\n"..
          "  msg('"..L["manaflowHelp1"].."')\n"..
          "  msg('"..L["manaflowHelp2"].."')\n"..
          "end\n"..
          "local function clearLinkList()\n"..
          "  for k,v in pairs(linkList) do\n"..
          "    linkList[k].link:Hide()\n"..
          "    linkList[k].link = nil\n"..
          "    linkList[k] = nil\n"..
          "  end\n"..
          "end\n"..
          "local function drawToken(x,y,w,h,l,tex)\n"..
          "  local f=CreateFrame(\"Frame\",nil,DUEL_CIRCLE)\n"..
          "  f:SetSize(w,h)\n"..
          "  f:SetPoint(\"CENTER\",DUEL_CIRCLE,\"CENTER\",x,y)\n"..
          "  f:SetFrameLevel(l)\n"..
          "  local t=f:CreateTexture(nil,\"BACKGROUND\")\n"..
          "  t:SetTexture(tex)\n"..
          "  t:SetAllPoints()\n"..
          "  f.tex=t\n"..
          "  return f\n"..
          "end\n"..
          "\n"..
          "function drawButton(t,x,y,w,l,func)\n"..
          "  local b=CreateFrame(\"Button\",nil,DUEL_CIRCLE,\"UIPanelButtonTemplate\")\n"..
          "  b:SetText(t)\n"..
          "  b:SetSize(w,20)\n"..
          "  b:SetFrameLevel(l)\n"..
          "  b:SetPoint(\"BOTTOMLEFT\",DUEL_CIRCLE,\"BOTTOMLEFT\",x,y)\n"..
          "  b:SetScript(\"OnClick\",func)\n"..
          "  return b\n"..
          "end\n"..
          "\n"..
          "local function drawRouteLine(T,C,sx,sy,ex,ey,w,relPoint)\n"..
          "  if not relPoint then relPoint=\"CENTER\" end\n"..
          "\n"..
          "  local linefactor_2=32/30/2\n"..
          "  local dx,dy=ex-sx, ey-sy\n"..
          "  local cx,cy=(sx+ex)/2, (sy+ey)/2\n"..
          "\n"..
          "  if dx<0 then dx,dy=-dx,-dy end\n"..
          "\n"..
          "  local l=sqrt((dx*dx) + (dy*dy))\n"..
          "\n"..
          "  if l==0 then\n"..
          "    T:SetTexCoord(0,0,0,0,0,0,0,0)\n"..
          "    T:SetPoint(\"BOTTOMLEFT\", C, relPoint, cx,cy)\n"..
          "    T:SetPoint(\"TOPRIGHT\", C, relPoint, cx,cy)\n"..
          "    return\n"..
          "  end\n"..
          "\n"..
          "  local s,c=-dy/l, dx/l\n"..
          "  local sc=s*c\n"..
          "\n"..
          "  local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy\n"..
          "  if dy>=0 then\n"..
          "    Bwid=((l*c) - (w*s))*linefactor_2\n"..
          "    Bhgt=((w*c) - (l*s))*linefactor_2\n"..
          "    BLx, BLy, BRy=(w/l)*sc, s*s, (l/w)*sc\n"..
          "    BRx, TLx, TLy, TRx=1 - BLy, BLy, 1 - BRy, 1 - BLx \n"..
          "    TRy=BRx\n"..
          "  else\n"..
          "    Bwid=((l*c) + (w*s))*linefactor_2\n"..
          "    Bhgt=((w*c) + (l*s))*linefactor_2\n"..
          "    BLx, BLy, BRx=s*s, -(l/w)*sc, 1 + (w/l)*sc\n"..
          "    BRy, TLx, TLy, TRy=BLx, 1 - BRx, 1 - BLx, 1 - BLy\n"..
          "    TRx=TLy\n"..
          "  end\n"..
          "\n"..
          "  T:ClearAllPoints()\n"..
          "  T:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy)\n"..
          "  T:SetPoint(\"BOTTOMLEFT\", C, relPoint, cx - Bwid, cy - Bhgt)\n"..
          "  T:SetPoint(\"TOPRIGHT\", C, relPoint, cx + Bwid, cy + Bhgt)\n"..
          "end\n"..
          "\n"..
          "local function getPosition()\n"..
          "  local y,x = UnitPosition(\"player\")\n"..
          "  return DUELL_KREIS_X-x,y-DUELL_KREIS_Y\n"..
          "end\n"..
          "\n"..
          "local function normalizeCoords(x,y)\n"..
          "  x,y = x*22,y*22\n"..
          "  return math.min(math.max(x,-220),220),math.min(math.max(y,-200),220)\n"..
          "end\n"..
          "\n"..
          "local function drawMember(name,x,y)\n"..
          "  x,y = normalizeCoords(x,y)\n"..
          "  local t = drawToken(x,y,30,30,60,nil)\n"..
          "  SetPortraitTexture(t.tex, name)\n"..
          "  MANA_MEMBERS[name] = { token = t, x=x, y=y }\n"..
          "  if name == UnitName(\"player\") then\n"..
          "    local a = drawToken(x,y,16,64,59,\"Interface/UNITPOWERBARALT/FUELGAUGE_HORIZONTAL_SPARK\")\n"..
          "    a.tex:SetTexCoord(0,1,26/64,58/64)\n"..
          "    local ag=a:CreateAnimationGroup()\n"..
          "    local r=ag:CreateAnimation(\"Rotation\")\n"..
          "    r:SetRadians(0)\n"..
          "    r:SetDuration(0)\n"..
          "    r:SetEndDelay(9)\n"..
          "    r:SetOrigin(\"CENTER\",0,0)\n"..
          "    r:SetSmoothing(\"IN_OUT\")\n"..
          "    a.rad=ag\n"..
          "    MANA_MEMBERS[name].arrow = a\n"..
          "  end\n"..
          "end\n"..
          "\n"..
          "local function updateAllMembers()\n"..
          "  for k,v in pairs(MANA_MEMBERS) do\n"..
          "    SetPortraitTexture(v.token.tex, k)\n"..
          "  end\n"..
          "end\n"..
          "\n"..
          "local function updateMember(name,x,y)\n"..
          "  x,y = normalizeCoords(x,y)\n"..
          "  MANA_MEMBERS[name].token:SetPoint(\"CENTER\",DUEL_CIRCLE,\"CENTER\",x,y)\n"..
          "  MANA_MEMBERS[name].x=x\n"..
          "  MANA_MEMBERS[name].y=y\n"..
          "  if name == UnitName(\"player\") then\n"..
          "    local a = MANA_MEMBERS[name].arrow\n"..
          "    a:SetPoint(\"CENTER\",DUEL_CIRCLE,\"CENTER\",x,y)\n"..
          "    local anim=a.rad:GetAnimations()\n"..
          "    anim:SetRadians(GetPlayerFacing())\n"..
          "    a.rad:Play()\n"..
          "  end\n"..
          "  \n"..
          "  for _,l in pairs(linkList) do\n"..
          "    if l.m1 == name or l.m2 == name then\n"..
          "      local sx, sy = MANA_MEMBERS[l.m1].x, MANA_MEMBERS[l.m1].y\n"..
          "      local ex, ey = MANA_MEMBERS[l.m2].x, MANA_MEMBERS[l.m2].y\n"..
          "      drawRouteLine(l.link.tex,DUEL_CIRCLE,sx,sy,ex,ey,25)\n"..
          "    end\n"..
          "  end\n"..
          "end\n"..
          "\n"..
          "local function removeMember(name)\n"..
          "  MANA_MEMBERS[name].token:Hide()\n"..
          "  MANA_MEMBERS[name].token = nil\n"..
          "  MANA_MEMBERS[name] = nil\n"..
          "end\n"..
          "\n"..
          "local function _close()\n"..
          "  send(\"leave\")\n"..
          "  for k,_ in pairs(MANA_MEMBERS) do\n"..
          "    removeMember(k)\n"..
          "  end\n"..
          "  clearLinkList() \n"..
          "  DUEL_CIRCLE:UnregisterEvent(\"GROUP_ROSTER_UPDATE\")\n"..
          "  DUEL_CIRCLE:UnregisterEvent(\"CHAT_MSG_ADDON\")\n"..
          "  DUEL_CIRCLE:SetScript(\"OnDragStart\",nil)\n"..
          "  DUEL_CIRCLE:SetScript(\"OnDragStop\",nil)\n"..
          "  DUEL_CIRCLE:SetScript(\"OnUpdate\",nil)\n"..
          "  DUEL_CIRCLE:SetScript(\"OnEvent\",nil)\n"..
          "  DUEL_CIRCLE:Hide()\n"..
          "  DUEL_CIRCLE = nil\n"..
          "  MANA_INIT = nil\n"..
          "end\n"..
          "\n"..
          "function _lshift(x, by)\n"..
          "  return x * 2^by\n"..
          "end\n"..
          "\n"..
          "local lshift14 = _lshift(1,14)\n"..
          "\n"..
          "local function isLinkCrossed(l1m1, l1m2, l2m1, l2m2)\n"..
          "  local d=(l2m2.y-l2m1.y)*(l1m2.x-l1m1.x) - (l2m2.x-l2m1.x)*(l1m2.y-l1m1.y)\n"..
          "  local n_a=(l2m2.x-l2m1.x)*(l1m1.y-l2m1.y)-(l2m2.y-l2m1.y)*(l1m1.x-l2m1.x)\n"..
          "  local n_b=(l1m2.x-l1m1.x)*(l1m1.y-l2m1.y)-(l1m2.y-l1m1.y)*(l1m1.x-l2m1.x)\n"..
          "  \n"..
          "  if d == 0 then\n"..
          "    return false\n"..
          "  end\n"..
          "\n"..
          "  local ua = _lshift(n_a,14)/d\n"

    code = code.."  local ub = _lshift(n_b,14)/d\n"..
          "  return ua >= 0 and ua <= lshift14 and ub >= 0 and ub <= lshift14\n"..
          "end\n"..
          "\n"..
          "local function crossedLinks()\n"..
          "  for i = 1,#linkList-1 do\n"..
          "    for j = i+1,#linkList do\n"..
          "      if linkList[i].m1 ~= linkList[j].m1 and \n"..
          "          linkList[i].m1 ~= linkList[j].m2 and\n"..
          "          linkList[i].m2 ~= linkList[j].m1 and\n"..
          "          linkList[i].m2 ~= linkList[j].m2 then\n"..
          "        local b = isLinkCrossed(MANA_MEMBERS[linkList[i].m1],\n"..
          "            MANA_MEMBERS[linkList[i].m2],MANA_MEMBERS[linkList[j].m1],\n"..
          "            MANA_MEMBERS[linkList[j].m2])\n"..
          "        if b then\n"..
          "          return true\n"..
          "        end\n"..
          "      end\n"..
          "    end\n"..
          "  end\n"..
          "  return false\n"..
          "end\n"..
          "\n"..
          "local function getMembers()\n"..
          "  local list = {}\n"..
          "  for m,_ in pairs(MANA_MEMBERS) do\n"..
          "    list[#list+1] = m\n"..
          "  end\n"..
          "  return list\n"..
          "end\n"..
          "\n"..
          "local function drawLink(m1, m2)\n"..
          "  local x,y=UIParent:GetCenter()\n"..
          "  local f=CreateFrame(\"Frame\",nil,DUEL_CIRCLE)\n"..
          "  local t=f:CreateTexture(nil,\"BACKGROUND\")\n"..
          "  t:SetTexture(\"Interface/TAXIFRAME/UI-Taxi-Line\")\n"..
          "  t:SetVertexColor(.6,.6,1)\n"..
          "  t:SetAllPoints()\n"..
          "  f:SetSize(DUEL_CIRCLE:GetWidth(),DUEL_CIRCLE:GetHeight())\n"..
          "  f:SetPoint(\"CENTER\",DUEL_CIRCLE,\"CENTER\",0,0)\n"..
          "  f:SetFrameLevel(58)\n"..
          "  f.tex=t\n"..
          "  local sx, sy = MANA_MEMBERS[m1].x, MANA_MEMBERS[m1].y\n"..
          "  local ex, ey = MANA_MEMBERS[m2].x, MANA_MEMBERS[m2].y\n"..
          "  drawRouteLine(f.tex,DUEL_CIRCLE,sx,sy,ex,ey,25)\n"..
          "  return f\n"..
          "end\n"..
          "\n"..
          "local function link(m1, m2)\n"..
          "  local l = drawLink(m1, m2)\n"..
          "  linkList[#linkList+1] = { m1 = m1, m2 = m2, link = l }\n"..
          "  PlaySoundFile(\"Sound/Spell/Spell_MK_breathoftheserpent_cast01.ogg\",\"Master\")\n"..
          "end\n"..
          "\n"..
          "local function setLevel()\n"..
          "  local m1, m2 = linkCandidates[gameLevel*2-1], linkCandidates[gameLevel*2]\n"..
          "  send(\"link:\"..m1..\":\"..m2)\n"..
          "  link(m1,m2)\n"..
          "  LEVEL_TIME = 3\n"..
          "end\n"..
          "local function setButtons()\n"..
          "  if gameMode == \"start\" or gameMode == \"leader\" then\n"..
          "    buttonStart:Disable()\n"..
          "    buttonStop:Enable()\n"..
          "    buttonCent:Disable()  \n"..
          "  elseif gameMode == \"stop\" then\n"..
          "    buttonStart:Enable()\n"..
          "    buttonStop:Disable()\n"..
          "    buttonCent:Enable()  \n"..
          "  end\n"..
          "end\n"..
          "local function stopGame()\n"..
          "  send(\"stop\")\n"..
          "  clearLinkList()\n"..
          "  gameMode = \"stop\"\n"..
          "  setButtons()\n"..
          "end\n"..
          "local function win()\n"..
          "  PlaySoundFile(\"Sound/INTERFACE/UI_51_BrawlersGuild_Victory_Alliance.OGG\",\"Master\")\n"..
          "  msg('"..L["manaflowWin"].."')\n"..
          "end\n"..
          "local function loss(txt)\n"..
          "  PlaySoundFile(\"Sound/INTERFACE/UI_51_BrawlersGuild_Loss_Horde.OGG\",\"Master\")\n"..
          "  msg(txt)\n"..
          "end\n"..
          "local function finishLevel()\n"..
          "  if crossedLinks() then\n"..
          "    local msg = \"\"\n"..
          "    msg = '"..L["manaflowLoose"].." '..gameLevel\n"..
          "    send(\"loss:\"..msg)\n"..
          "    loss(msg)\n"..
          "    stopGame()\n"..
          "    return\n"..
          "  elseif gameLevel*2 == #linkCandidates or \n"..
          "      (gameLevel > 4 and gameLevel == (#(getMembers())-5)*2 + 9) then\n"..
          "    send(\"win\")\n"..
          "    win()\n"..
          "    stopGame()\n"..
          "    return\n"..
          "  end\n"..
          "  gameLevel = gameLevel + 1\n"..
          "  setLevel()\n"..
          "end\n"..
          "\n"..
          "local function shuffleTable(t)\n"..
          "  local rand = math.random\n"..
          "  local num = #t\n"..
          "  local j\n"..
          "\n"..
          "  for i = num, 2, -1 do\n"..
          "    j = rand(i)\n"..
          "    t[i], t[j] = t[j], t[i]\n"..
          "  end\n"..
          "  return t\n"..
          "end\n"..
          "\n"..
          "local function contains(_table, elem)\n"..
          "  for _,val in pairs(_table) do\n"..
          "    if val == elem then\n"..
          "      return true\n"..
          "    end\n"..
          "  end\n"..
          "  return false\n"..
          "end\n"..
          "\n"..
          "function _remove(_table, elem)\n"..
          "  for i, val in ipairs(_table) do\n"..
          "    if val == elem then\n"..
          "      table.remove(_table, i)\n"..
          "    end\n"..
          "  end\n"..
          "end\n"..
          "local function setLinkCandidates()\n"..
          "  local members = getMembers()\n"..
          "\n"..
          "  local cases = {}\n"..
          "  for i = 1,#members-1 do\n"..
          "    for j = i+1,#members do\n"..
          "      cases[#cases+1] = members[i]..\":\"..members[j]\n"..
          "    end\n"..
          "  end\n"..
          "  shuffleTable(cases)\n"..
          "    \n"..
          "  local pos = 1\n"..
          "  for i = 1,#cases do\n"..
          "    local m1, m2 = strsplit(\":\",cases[i])\n"..
          "    for j = #members,1,-1 do\n"..
          "      if #members == 1 and\n"..
          "          (contains(members,m1) or contains(members,m2)) then\n"..
          "        cases[i],cases[pos] = cases[pos],cases[i]\n"..
          "        members={}\n"..
          "      elseif contains(members,m1) and contains(members,m2) then\n"..
          "        cases[i],cases[pos] = cases[pos],cases[i]\n"..
          "        _remove(members,m1)\n"..
          "        _remove(members,m2)\n"..
          "        pos = pos + 1\n"..
          "      end\n"..
          "    end\n"..
          "    if #members == 0 then\n"..
          "      break\n"..
          "    end\n"..
          "  end\n"..
          "  \n"..
          "  linkCandidates =  {}\n"..
          "  for i = 1,#cases do\n"..
          "    local m1, m2 = strsplit(\":\",cases[i])\n"..
          "    linkCandidates[#linkCandidates+1] = m1\n"..
          "    linkCandidates[#linkCandidates+1] = m2\n"..
          "  end\n"..
          "end\n"..
          "local function newGame()\n"..
          "  if #(getMembers()) <= 3 then\n"..
          "    msg('"..L["manaflowTooFew"].."')\n"..
          "    return\n"..
          "  end\n"..
          "  send(\"start\")\n"..
          "  clearLinkList()\n"..
          "  gameMode = \"leader\"\n"..
          "  gameLevel = 1\n"..
          "  setLinkCandidates()\n"..
          "  setLevel()\n"..
          "  setButtons()\n"..
          "end\n"..
          "\n"..
          "local function checkMsg(msg,sender)\n"..
          "  local id,sx,sy = strsplit(\":\",msg)\n"..
          "  if id == \"pos\" then\n"..
          "    local x,y = tonumber(sx),tonumber(sy)\n"..
          "    if MANA_MEMBERS[sender] == nil then\n"..
          "      drawMember(sender,x,y)\n"
  code = code.."    end\n"..
          "    updateMember(sender,x,y)\n"..
          "  elseif id == \"start\" then\n"..
          "    setButtons()\n"..
          "  elseif id == \"stop\" then\n"..
          "    clearLinkList()\n"..
          "    setButtons()\n"..
          "  elseif id == \"leave\" and sender ~= UnitName(\"player\") then\n"..
          "    removeMember(sender)\n"..
          "  elseif id == \"link\" then\n"..
          "    link(sx, sy)\n"..
          "  elseif id == \"center\" then\n"..
          "    DUELL_KREIS_X,DUELL_KREIS_Y = tonumber(sx),tonumber(sy)\n"..
          "  elseif id == \"msg\" then\n"..
          "    msg(sx)\n"..
          "  elseif id == \"win\" then\n"..
          "    win()\n"..
          "  elseif id == \"loss\" then\n"..
          "    loss(sx)\n"..
          "  end\n"..
          "end\n"..
          "\n"..
          "local function onEvent(self,event,arg1,arg2,arg3,arg4)\n"..
          "  if event == \"CHAT_MSG_ADDON\" then\n"..
          "    if arg1 ~= PREFIX then\n"..
          "      return\n"..
          "    end\n"..
          "    local sender = strsplit(\"-\",arg4)\n"..
          "    checkMsg(arg2,sender)\n"..
          "  elseif event == \"GROUP_ROSTER_UPDATE\" then\n"..
          "    if not IsInGroup() then\n"..
          "      _close()\n"..
          "      return\n"..
          "    end\n"..
          "    for k,_ in pairs(MANA_MEMBERS) do\n"..
          "      if UnitInParty(k) == nil and UnitInRaid(k) == nil then\n"..
          "        removeMember(k)\n"..
          "      end\n"..
          "    end\n"..
          "    msg('"..L["manaflowPlayers"].."')\n"..
          "    stopGame()\n"..
          "  end\n"..
          "end\n"..
          "local function onUpdate(self,elapsed)\n"..
          "  MANA_COUNTER = MANA_COUNTER + elapsed\n"..
          "  GLOW_COUNTER = GLOW_COUNTER + elapsed\n"..
          "  if MANA_COUNTER >= .1 then\n"..
          "    MANA_COUNTER = 0\n"..
          "    local x,y = getPosition()\n"..
          "    updateMember(UnitName(\"player\"),x,y)\n"..
          "    send(\"pos:\"..x..\":\"..y)\n"..
          "  end\n"..
          "  if GLOW_COUNTER >= 4 then\n"..
          "    GLOW_COUNTER = 0\n"..
          "    updateAllMembers()\n"..
          "  end\n"..
          "  if LEVEL_TIME > 0 and gameMode == \"leader\" then\n"..
          "    LEVEL_TIME = LEVEL_TIME - elapsed\n"..
          "    if LEVEL_TIME <= 0 then\n"..
          "      finishLevel()\n"..
          "    end\n"..
          "  end\n"..
          "  \n"..
          "  local o = GLOW_COUNTER\n"..
          "  if o >= 2 then o = 4-GLOW_COUNTER end\n"..
          "  DUEL_CIRCLE.circle.tex:SetVertexColor(.25 - (o/20-.05),.5 - (o/20-.05),1,1)\n"..
          "end\n"..
          "\n"..
          "local function drawCircle()\n"..
          "  local f = CreateFrame(\"Frame\",\"\"..time(),UIParent)\n"..
          "  DUEL_CIRCLE = f\n"..
          "  \n"..
          "  f:SetClampedToScreen(true)\n"..
          "  f:SetMovable(true)\n"..
          "  f:EnableMouse(true)\n"..
          "  f:RegisterForDrag(\"LeftButton\",\"RightButton\")\n"..
          "  f:SetScript(\"OnDragStart\",function() f:StartMoving() end)\n"..
          "  f:SetScript(\"OnDragStop\",function() f:StopMovingOrSizing() end)\n"..
          "  f:SetScript(\"OnUpdate\",onUpdate)\n"..
          "  f:SetScript(\"OnEvent\",onEvent)\n"..
          "  f:RegisterEvent(\"CHAT_MSG_ADDON\")\n"..
          "  f:RegisterEvent(\"GROUP_ROSTER_UPDATE\")\n"..
          "  C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)\n"..
          "  \n"..
          "  local bd = { edgeFile=\"Interface/Tooltips/UI-Tooltip-Border\",tile=true,tileSize=6,edgeSize=6,insets={ left=4,right=4,top=4,bottom=4 } }\n"..
          "  f:SetBackdrop(bd)\n"..
          "  local t=f:CreateTexture(nil,\"BACKGROUND\")\n"..
          "  t:SetAllPoints()\n"..
          "  t:SetTexture(.4,.4,.4,.5)\n"..
          "  f:SetSize(500,500)\n"..
          "  f:SetPoint(\"CENTER\", UIParent, \"CENTER\",0,0)\n"..
          "  f:SetFrameLevel(50)\n"..
          "  \n"..
          "  local cls=CreateFrame(\"Button\",nil,f,\"UIPanelCloseButton\")\n"..
          "  cls:SetPoint(\"TOPRIGHT\",0,0)\n"..
          "  cls:SetScript(\"OnMouseUp\",_close)\n"..
          "  \n"..
          "  local c1 = drawToken(0,0,400,400,51,\"Interface/CHARACTERFRAME/TempPortraitAlphaMask\")\n"..
          "  c1.tex:SetVertexColor(.3,.3,.4,1)\n"..
          "  \n"..
          "  local c2 = drawToken(0,0,390,390,52,\"Interface/SPELLBOOK/UI-GlyphFrame-Glow\")\n"..
          "  c2.tex:SetTexCoord(0,372/512,14/512,387/512)\n"..
          "  c2.tex:SetVertexColor(.2,.5,1,1)\n"..
          "  DUEL_CIRCLE.circle = c2\n"..
          "  \n"..
          "  buttonStart = drawButton('"..L["manaflowBtnNew"].."',2,2,100,59,newGame)\n"..
          "  buttonStop = drawButton('"..L["manaflowBtnStop"].."',103,2,100,59,stopGame)\n"..
          "  buttonCent = drawButton('"..L["manaflowBtnCenter"].."',294,2,100,59,cmdCenter)\n"..
          "  buttonHelp = drawButton('"..L["manaflowBtnHelp"].."',397,2,100,59,cmdHelp)\n"..
          "  setButtons()\n"..
          "end\n"..
          "\n"..
          "local function init()\n"..
          "  MANA_MEMBERS = {}\n"..
          "  drawCircle()\n"..
          "  local x,y = getPosition()\n"..
          "  drawMember(UnitName(\"player\"),x,y)\n"..
          "  MANA_INIT = true\n"..
          "end\n"..
          "\n"..
          "if MANA_INIT then\n"..
          "  _close()\n"..
          "else\n"..
          "  init()\n"..
          "end\n"
  return code
end
