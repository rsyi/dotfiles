-- Spectacle emulation.
-- hs.loadSpoon("Lunette")
-- spoon.Lunette:bindHotkeys()

-- Control when held, escape when tapped.
keyUpDown = function(modifiers, key)
  hs.eventtap.keyStroke(modifiers, key, 0)
end
require('control-escape')
hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()

