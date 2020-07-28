RPManagerItems = LibStub("AceAddon-3.0"):NewAddon("RPManagerItems",
    "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale("RPManagerItems")

local items = {}

--
-- Init
--

local function greet(num)
  RPMUtil.msg(L["greet1"])
  RPMUtil.msg(string.format(L["greet2"], num))
end

function RPManagerItems:OnInitialize()
  local num = self:registerItems()
  greet(num)
end

function RPManagerItems:OnEnable()

end

function RPManagerItems:OnDisable()

end

function RPManagerItems:registerItems()
  local count = 0
  for key, val in pairs(self) do
    if RPMUtil.startsWith(key, "doRegister") then
      local id = key:gsub("doRegister", "")
      items[id] = val
      count = count + 1
    end
  end
  return count
end

function RPManagerItems:getItems()
  return items
end

function RPManagerItems:getItem(id)
  return loadstring("return RPManagerItems:getCustomization"..id.."()")(),
      loadstring("return RPManagerItems:getCode"..id.."()")()
end
