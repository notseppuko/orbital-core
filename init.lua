local WindowData = require(path.ui.window)
local UI      = WindowData.UI
local Window  = WindowData.Window

require(path.features.movement)(Window, UI)
require(path.ui.settings)(Window, UI, WindowData.UIScale)
require(path.core.utils)(UI)
