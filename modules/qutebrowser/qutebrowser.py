config.load_autoconfig()

config.bind(",", "download-open")
config.bind("J", "scroll-page 0 1")
config.bind("K", "scroll-page 0 -1")
config.bind("M", "spawn mpv {url}")
config.bind("R", "config-source")
config.bind("d", "edit-url")
config.bind("u", "set-cmd-text :open !")

c.url.start_pages = "file:///etc/qb-start.svg"
c.url.default_page = c.url.start_pages

c.content.autoplay = False
c.content.cookies.accept = "no-3rdparty"
c.content.fullscreen.window = True
c.content.geolocation = False
c.content.notifications.enabled = False
c.content.webgl = False
c.content.webrtc_ip_handling_policy = "default-public-interface-only"

c.downloads.location.directory = "~/new"
c.downloads.location.prompt = False
c.downloads.location.remember = False

c.editor.command = ["term", "-e", "nvim", "{file}"]

c.fonts.default_size = "12.5pt"

c.tabs.show = "never"
c.tabs.tabs_are_windows = True

c.zoom.default = 125
