keyUpDown = function(modifiers, key)
  hs.eventtap.keyStroke(modifiers, key, 0)
end
require('control-escape')
hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()

hs.hotkey.bind({"option"}, "space", function()
  local alacritty = hs.application.find('alacritty')
  if alacritty:isFrontmost() then
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
  end
end)

hs.hotkey.bind({"option"}, "n", function()
  local notion = hs.application.find('notion')
  if notion:isFrontmost() then
    notion:hide()
  else
    hs.application.launchOrFocus("/Applications/Notion.app")
  end
end)

hs.hotkey.bind({"option"}, "s", function()
  local notion = hs.application.find('slack')
  if notion:isFrontmost() then
    notion:hide()
  else
    hs.application.launchOrFocus("/Applications/Slack.app")
  end
end)

hs.hotkey.bind({"option"}, "c", function()
  local notion = hs.application.find('chrome')
  if notion:isFrontmost() then
    notion:hide()
  else
    hs.application.launchOrFocus("/Applications/Google Chrome.app")
  end
end)

hs.hotkey.bind({"option"}, "f", function()
  local notion = hs.application.find('figma')
  if notion:isFrontmost() then
    notion:hide()
  else
    hs.application.launchOrFocus("/Applications/Figma.app")
  end
end)

--------------------------------
-- START VIM CONFIG
--------------------------------
local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

-- Configure apps you do *not* want Vim mode enabled in
-- For example, you don't want this plugin overriding your control of Terminal
-- vim
vim
  :disableForApp('Code')
  :disableForApp('zoom.us')
  :disableForApp('iTerm')
  :disableForApp('iTerm2')
  :disableForApp('Terminal')
  :disableForApp('Alacritty')

-- If you want the screen to dim (a la Flux) when you enter normal mode
-- flip this to true.
vim:shouldDimScreenInNormalMode(false)

-- If you want to show an on-screen alert when you enter normal mode, set
-- this to true
vim:shouldShowAlertInNormalMode(true)

-- You can configure your on-screen alert font
vim:setAlertFont("Courier New")

-- Enter normal mode by typing a key sequence
-- vim:enterWithSequence('jk')

-- if you want to bind a single key to entering vim, remove the
-- :enterWithSequence('jk') line above and uncomment the bindHotKeys line
-- below:
--
-- To customize the hot key you want, see the mods and key parameters at:
--   https://www.hammerspoon.org/docs/hs.hotkey.html#bind
--
vim:bindHotKeys({ enter = { {'cmd'}, ';' } })

--------------------------------
-- END VIM CONFIG
--------------------------------
