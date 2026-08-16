local dock_apps = {
	"Firefox",
	"Finder",
	"kitty",
	"Terminal",
	"Alacritty",
	"Google Chrome",
	"Safari",
	"Messages",
}

-- shortcuts for dock items
for index, app_name in ipairs(dock_apps) do
	hs.hotkey.bind({"alt"}, tostring(index), function()
		hs.application.launchOrFocus(app_name)
	end)
end

-- super + enter to launch a new terminal
hs.hotkey.bind({"alt"}, "return", function()
	hs.task.new("/usr/bin/open", nil, {"-na", "kitty"}):start()
end)

-- auto-reload config after save
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.notify.new({title = "hammerspoon", informativeText = "config loadded succesfully"}):send()

-- do not open sonsole window on launch
hs.console.titleVisibility("hidden")
