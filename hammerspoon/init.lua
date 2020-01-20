--[ Defines ]-------------------------------------------------------------

local hyper = { "cmd", "alt", "ctrl", "shift" }	-- caps lock held down
-- shyper = {"⌘", "⌥", "⇧", "⌃"}	-- caps lock held down, with shift
hs.window.animationDuration = 0
local util = {}
local layouts = {}
local macScreenName = "Color LCD"
local homeMonitorName = "VE247"


--[ Functions ]-----------------------------------------------------------

function findOrLaunch(a)
	local app = hs.application.find(a)
	if not app then
		hs.application.launchOrFocus(a)
	end
	return hs.application.find(a)
end

function fancyNotify(t,m)
    hs.notify.new({title=t, informativeText=m}):send():release()
end

-- Creates hotkey bindings for all hotkeys specified in the config.
--
-- The `configs` argument should be a list of argument tables that will be
-- passed directly into `hs.hotkey.bind`.
--
-- Args:
--     configs, table: a list of argument tables to be passed to `hs.hotkey.bind`
function util.bindAll(configs)
  for i, config in ipairs(configs) do
      hs.hotkey.bind(table.unpack(config))
  end
end


--[ Key Bindings ]--------------------------------------------------------

hs.hotkey.bind(hyper, "H", function()
  -- hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
  fancyNotify("Hammerspoon","Hello World")
end)

--[ Config Management ]---------------------------------------------------

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
      -- fancyNotify("Hammerspoon", "Config reloaded!! 😎")
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall


--[ Layout Management ]---------------------------------------------------

local function applyNoMonitorLayout(macScreen)
  fancyNotify("LayoutManager","TODO: You haven't setup single screen configs yet ⚠")
end

local function applyHomeLayout(macScreen, homeMonitor)
  fancyNotify("LayoutManager","Applying Double Monitor")
  fancyNotify("LayoutManager",macScreen:name())
  fancyNotify("LayoutManager",homeMonitor:name())
  -- local laptopScreen = "Color LCD"
  -- local windowLayout = {
  --     {"Safari",  nil,          laptopScreen, hs.layout.left50,    nil, nil},
  --     {"Mail",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
  --     {"iTunes",  "iTunes",     laptopScreen, hs.layout.maximized, nil, nil},
  --     {"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
  -- }
  -- hs.layout.apply(windowLayout)
end

local function applyWorkLayout()
  fancyNotify("LayoutManager","TODO: You haven't setup work screen configs yet ⚠")
end

function layouts.applyLayoutForScreens()
  local allScreens = hs.screen.allScreens()

  local macScreen = hs.screen(macScreenName)
  local homeMonitor = hs.screen(homeMonitorName)

  if #allScreens == 1 then
    applyNoMonitorLayout(macScreen)
  elseif #allScreens == 2 and homeMonitor then
    applyHomeLayout(macScreen, homeMonitor)
  elseif #allScreens == 3 then
    applyWorkLayout()
  end
end

hs.screen.watcher.new(layouts.applyLayoutForScreens):start()
hs.hotkey.bind(hyper, "return", function()
  layouts.applyLayoutForScreens()
end)

function test()
  local macScreen = hs.screen(macScreenName)
--   > hs.window.find('Recents')
-- hs.window: Recents (0x6000033e2068)

-- hs.application.find('Microsoft Outlook'):allWindows()[1]
-- hs.window: Calendar (0x6000033cda68)

-- Opened new email and got this
-- > hs.application.find('Microsoft Outlook'):allWindows()[1]
-- hs.window: Untitled • as027811@cerner.net (0x60000323bbf8)

-- > hs.application.find('Microsoft Outlook'):allWindows()[0]
-- nil

-- > hs.application.find('Microsoft Outlook'):allWindows()[2]
-- hs.window: Inbox • as027811@cerner.net (0x600003215af8)

-- Deprecated
  -- local finder = hs.appfinder.appFromName("Finder")
  -- hs.window('spotify')
  finder:moveToScreen(macScreen)
  fancyNotify("LayoutManager",finder:name())
end

hs.hotkey.bind(hyper, "j", test)


--[ Notes ]------------------------------------------------------------
--[[

  Random Links:
    -- https://github.com/Hammerspoon/hammerspoon/wiki/Sample-Configurations
    -- http://www.hammerspoon.org/go/
    -- http://www.hammerspoon.org/Spoons/
    -- https://www.hammerspoon.org/docs/
    -- https://medium.com/@robhowlett/hammerspoon-the-best-mac-software-youve-never-heard-of-40c2df6db0f8
    -- Basic example with layouts and shortcuts for apps https://github.com/fenetikm/dotfiles/blob/master/.hammerspoon/init.lua
    -- https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.hammerspoon/init.lua

  Ideas:
    -- Detect number of monitors plugged in and organize screens
    -- How to connect these scripts to last pass cli
    -- tmux integration for jumpgates?
    -- When home or at work control audio
    -- Auto keep github repos up to date
    -- Organize files in separate folders or files in hammerspoon based off what they do and require like `local cheaphints = require "cheaphints"`
    -- Epicrome setup
      -- https://github.com/dmarmor/epichrome
      -- Example of usage
      --  https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/#organization-and-productivity
      --  https://github.com/zzamboni/dot-hammerspoon/blob/master/init.lua#L29



  Possible Inputs:

  Possible Affects:

  Random Code Notes:
    -- work_logo = hs.image.imageFromPath(hs.configdir .. "/files/work_logo_2x.png")

    EXAMPLE: Menu item
    caffeine = hs.menubar.new()
    function setCaffeineDisplay(state)
        if state then
            caffeine:setTitle("AWAKE")
        else
            caffeine:setTitle("SLEEPY")
        end
    end

    function caffeineClicked()
        setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
    end

    if caffeine then
        caffeine:setClickCallback(caffeineClicked)
        setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
    end

    EXAMPLE: Interact with Appf
    function cycle_safari_agents()
      hs.application.launchOrFocus("Safari")
      local safari = hs.appfinder.appFromName("Safari")

      local str_default = {"Develop", "User Agent", "Default (Automatically Chosen)"}
      local str_ie10 = {"Develop", "User Agent", "Internet Explorer 10.0"}
      local str_chrome = {"Develop", "User Agent", "Google Chrome — Windows"}

      local default = safari:findMenuItem(str_default)
      local ie10 = safari:findMenuItem(str_ie10)
      local chrome = safari:findMenuItem(str_chrome)

      if (default and default["ticked"]) then
          safari:selectMenuItem(str_ie10)
          hs.alert.show("IE10")
      end
      if (ie10 and ie10["ticked"]) then
          safari:selectMenuItem(str_chrome)
          hs.alert.show("Chrome")
      end
      if (chrome and chrome["ticked"]) then
          safari:selectMenuItem(str_default)
          hs.alert.show("Safari")
      end
    end

    EXAMPLE: Respond to events from apps like activated
    function applicationWatcher(appName, eventType, appObject)
      if (eventType == hs.application.watcher.activated) then
          if (appName == "Finder") then
              -- Bring all Finder windows forward when one gets activated
              appObject:selectMenuItem({"Window", "Bring All to Front"})
          end
      end
    end
    appWatcher = hs.application.watcher.new(applicationWatcher)
    appWatcher:start()

    hs.hotkey.bind(hyper, "v", function()hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

    EXAMPLE: Listen for wifi
    local wifiMenu = hs.menubar.new()
    function ssidChangedCallback()
        SSID = hs.wifi.currentNetwork()
        if SSID == nil then
            SSID = "Disconnected"
        end
        wifiMenu:setTitle("(" .. SSID .. ")" )
    end
    wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
    wifiWatcher:start()
    ssidChangedCallback()

    EXAMPLE: Hook this in to unmute and turn on caffeine when home
    hs.audiodevice.defaultOutputDevice():setMuted(false)
    hs.caffeinate.set("displayIdle", true, true)


    function pingResult(object, message, seqnum, error)
      if message == "didFinish" then
          avg = tonumber(string.match(object:summary(), '/(%d+.%d+)/'))
          if avg == 0.0 then
              hs.alert.show("No network")
          elseif avg < 200.0 then
              hs.alert.show("Network good (" .. avg .. "ms)")
          elseif avg < 500.0 then
              hs.alert.show("Network poor(" .. avg .. "ms)")
          else
              hs.alert.show("Network bad(" .. avg .. "ms)")
          end
      end
    end
    hs.hotkey.bind(hyper, "p", function()hs.network.ping.ping("8.8.8.8", 1, 0.01, 1.0, "any", pingResult)end)


    function batteryChangedCallback()
      psuSerial = hs.battery.psuSerial()
      if psuSerial ~= 5848276 and psuSerial ~=0 and psuSerial ~= lastPsuSerial then
          hs.alert.show("That's not your power supply!")
      end
      lastPsuSerial = psuSerial
    end
    lastPsuSerial = 9999999
    batteryWatcher = hs.battery.watcher.new(batteryChangedCallback)
    batteryWatcher:start()

    micMuteStatusMenu = hs.menubar.new()
    micMuteStatusLine = nil
    function displayMicMuteStatus()
        local currentAudioInput = hs.audiodevice.current(true)
        local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
        muted = currentAudioInputObject:inputMuted()
        if muted then
            micMuteStatusMenu:setIcon(os.getenv("HOME") .. "/.hammerspoon/muted.png")
            micMuteStatusLineColor = {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=0.7}
        else
            micMuteStatusMenu:setIcon(os.getenv("HOME") .. "/.hammerspoon/unmuted.png")
            micMuteStatusLineColor = {["red"]=1,["blue"]=0,["green"]=1,["alpha"]=0.7}
        end
        if micMuteStatusLine then
            micMuteStatusLine:delete()
        end
        max = hs.screen.primaryScreen():fullFrame()
        micMuteStatusLine = hs.drawing.rectangle(hs.geometry.rect(max.x, max.y, max.w, max.h))
        micMuteStatusLine:setStrokeColor(micMuteStatusLineColor)
        micMuteStatusLine:setFillColor(micMuteStatusLineColor)
        micMuteStatusLine:setFill(false)
        micMuteStatusLine:setStrokeWidth(30)
        micMuteStatusLine:show()
    end
    for i,dev in ipairs(hs.audiodevice.allInputDevices()) do
      dev:watcherCallback(displayMicMuteStatus):watcherStart()
    end
    function toggleMicMuteStatus()
        local currentAudioInput = hs.audiodevice.current(true)
        local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
        currentAudioInputObject:setInputMuted(not muted)
        displayMicMuteStatus()
    end
    displayMicMuteStatus()
    hs.hotkey.bind(hyper, "m", toggleMicMuteStatus)
    micMuteStatusMenu:setClickCallback(toggleMicMuteStatus)
    function toggleMicMuteStatusAlert()
        if micMuteStatusAlert then
            micMuteStatusAlert = false
            micMuteStatusLine:delete()
        else
            micMuteStatusAlert = true
            displayMicMuteStatus()
        end
    end

--]]