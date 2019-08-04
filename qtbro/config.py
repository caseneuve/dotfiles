# -*- eval:(rainbow-mode) -*-

#            #      #
#   ### # # ### ### ### ### ### # #  ## ### ###
#   # # # #  #  ##  # # #   # # ###  #  ##  #
#   ### ###  ## ### ### #   ### ### ##  ### #
#     #

# Last update: 2019-08-01, 17:17:00 @lenovo

# * MY VARIABLES
mpv_script_video = "~/.scripts/mpvsoc -v "
mpv_script_audio = "~/.scripts/mpvsoc -a "

# * BACKEND
c.backend = "webengine"

# * COLORS
c.colors.completion.category.bg = "#888888"
c.colors.completion.even.bg = "#505050"
c.colors.completion.odd.bg = "#505050"

c.colors.messages.error.bg = "#c0392b"
c.colors.messages.info.bg = "green"

c.colors.statusbar.caret.bg = "#EC407A"
c.colors.statusbar.caret.fg = "#e1e1e0"
c.colors.statusbar.caret.selection.fg = "#e1e1e0"
c.colors.statusbar.command.bg = "#b33939"
c.colors.statusbar.command.fg = "#F7F7F7"
c.colors.statusbar.command.private.bg = "grey"
c.colors.statusbar.insert.bg = "#218c74"
c.colors.statusbar.insert.fg = "#e1e1e0"
c.colors.statusbar.normal.bg = "#14191f"
c.colors.statusbar.normal.fg = "#e1e1e0"
c.colors.statusbar.passthrough.bg = "#227093"
c.colors.statusbar.passthrough.fg = "#e1e1e0"
c.colors.statusbar.private.bg = "grey"
c.colors.statusbar.progress.bg = "#e1e1e0"
c.colors.statusbar.progress.bg = "#104e8b"
c.colors.statusbar.url.fg = "#e1e1e0"
c.colors.statusbar.url.hover.fg = "#00E5FF"
c.colors.statusbar.url.success.http.fg = "#e1e1e0"
c.colors.statusbar.url.success.https.fg = "#e1e1e0"

c.colors.tabs.even.bg = "#191f26"
c.colors.tabs.even.fg = "#bdc3c7"
c.colors.tabs.indicator.start = "#191f26"
c.colors.tabs.indicator.stop = "#191f26"
c.colors.tabs.odd.bg = "#191f26"
c.colors.tabs.odd.fg = "#bdc3c7"
c.colors.tabs.selected.even.bg = "#F7F7F7"
c.colors.tabs.selected.even.fg = "black"
c.colors.tabs.selected.odd.bg = "#F7F7F7"
c.colors.tabs.selected.odd.fg = "black"

c.colors.webpage.bg = "#F7F7F7"

# * COMPLETION
c.completion.height = "50%"
c.completion.scrollbar.padding = 0
c.completion.scrollbar.width = 0
c.completion.show = "auto"

# * CONFIRM
c.confirm_quit = ["always"]

# * CONTENT
c.content.cache.size = None
c.content.cookies.store = True

# * DOWNLOADS
c.downloads.location.directory = "~/dwl"
c.downloads.location.prompt = True
c.downloads.location.remember = True
c.downloads.location.suggestion = "path"
c.downloads.open_dispatcher = None
c.downloads.position = "bottom"

# * EDITOR
c.editor.command = ["st", "-e", "emacsclient", "-nw", "-s", "term", "{}"]

# * FONTS
c.fonts.completion.category = "9pt Monospace"
c.fonts.completion.entry = "9pt Monospace"
c.fonts.debug_console = "9pt Monospace"
c.fonts.downloads = "8pt Monospace"
c.fonts.hints = "9pt Roboto"
c.fonts.keyhint = "9pt Monospace"
c.fonts.messages.error = "8pt Monospace"
c.fonts.messages.info = "8pt Monospace"
c.fonts.messages.warning = "8pt Monospace"
c.fonts.prompts = "9pt Monospace"
c.fonts.statusbar = "9pt Monospace"
c.fonts.tabs = "10pt Roboto Condensed"

# * HINTS
c.hints.border = "1px solid #E3BE23"
c.hints.chars = "asdfghjkl"
c.hints.dictionary = "/usr/share/dict/words"
c.hints.min_chars = 1
c.hints.hide_unmatched_rapid_hints = True


# * PROMPT
c.prompt.filebrowser = True

# * SEARCH
c.search.ignore_case = "always"

# * SESSION
c.session.default_name = None

# * STATUS BAR
c.statusbar.hide = False
c.statusbar.position = "bottom"

# * TABS
c.tabs.background = True
c.tabs.close_mouse_button = "middle"
c.tabs.last_close = "close"
c.tabs.position = "top"
c.tabs.select_on_remove = "prev"
c.tabs.show = "multiple"

# * URL
c.url.auto_search = "naive"
c.url.start_pages = "file:///home/piotr/.dotfiles/qtbro/startpage.html"
c.url.default_page = "file:///home/piotr/.dotfiles/qtbro/newtab.html"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "aa": "https://allegro.pl/listing?string={}&order=d&bmatch=ss-base-relevance-floki-5-nga-hcp-wp-ele-1-1-0328",
    "al": "https://wiki.archlinux.org/index.php/{}",
    "bib": "http://katalogi.bn.org.pl/iii/encore/search/C__S{}__U?lang=pol&suite=cobalt",
    "et": "https://www.etymonline.com/word/{}",
    "gen": "http://gen.lib.rus.ec/search.php?req={}",
    "gg": "https://www.google.pl/search?dcr=0&source=hp&ei=_b_EWsi2DoHpsQG_t4-gBw&q={}",
    "go": "https://godoc.org/{}",
    "img": "https://www.google.com/search?tbm=isch&source=hp&biw=1366&bih=688&ei=O4fEWo2xLYuQkwWI_q3gDA&q={}",
    "lat": "archives.nd.edu/cgi-bin/wordz.pl?keyword=/{}",
    "map": "https://www.google.com/maps/place/{}",
    "mg": "https://www.google.com/maps/place/{}",
    "pers": "http://www.perseus.tufts.edu/hopper/searchresults?q={}",
    "py": "https://duckduckgo.com/?q=python+{}&ia=webqutebrowser+",
    "q": "https://duckduckgo.com/?q=qutebrowser+{}&ia=webqutebrowser+",
    "sjp": "https://sjp.pl/{}",
    "sx": "https://emacs.stackexchange.com/search?q={}",
    "we": "https://en.wikipedia.org/wiki/{}",
    "wi": "https://pl.wikipedia.org/wiki/{}",
    "wl": "https://en.wiktionary.org/wiki/{}",
    "ww": "archives.nd.edu/cgi-bin/wordz.pl?keyword=/{}",
    "yt": "https://www.youtube.com/results?search_query={}&page=&utm_source=opensearch",
}

# * ZOOM LEVELS
c.zoom.levels = [
    "25%",
    "33%",
    "50%",
    "67%",
    "75%",
    "90%",
    "100%",
    "110%",
    "125%",
    "150%",
    "175%",
    "200%",
    "250%",
    "300%",
    "400%",
    "500%",
]

# * KEY BINDINGS (KBD)
c.aliases = {"w": "session-save", "q": "quit", "wq": "quit --save"}

config.bind(",", "enter-mode insert")
config.bind("-", "zoom-out")
config.bind("0", "zoom")
config.bind(";", "move-to-end-of-line", mode="caret")
config.bind(";A", ':spawn i3-msg "exec --no-startup-id ' + mpv_script_audio + '{url}"')
config.bind(";O", "hint links fill :open -t -r {hint-url}")
config.bind(";V", ':spawn i3-msg "exec --no-startup-id ' + mpv_script_video + '{url}"')
config.bind(
    ";a",
    'hint links fill :spawn i3-msg "exec --no-startup-id '
    + mpv_script_audio
    + '{hint-url}"',
)
config.bind(";o", "hint links fill :open -t {hint-url}")
config.bind(
    ";v",
    'hint links fill :spawn i3-msg "exec --no-startup-id '
    + mpv_script_video
    + '{hint-url}"',
)
config.bind("<Alt-9>", "tab-focus 9")
config.bind("<Alt-;>", "tab-focus -1")
config.bind("<Alt-Shift-J>", "tab-move -")
config.bind("<Alt-Shift-L>", "tab-move +")
config.bind("<Alt-h>", "tab-focus 1")
config.bind("<Alt-j>", "tab-prev")
config.bind("<Alt-l>", "tab-next")
config.bind("<Ctrl-G>", "clear-keychain", mode="normal")
config.bind("<Ctrl-G>", "leave-mode", mode="caret")
config.bind("<Ctrl-G>", "leave-mode", mode="command")
config.bind("<Ctrl-G>", "leave-mode", mode="hint")
config.bind("<Ctrl-G>", "leave-mode", mode="insert")
config.bind("<Ctrl-G>", "leave-mode", mode="prompt")
config.bind("<Ctrl-Space>", "drop-selection", mode="caret")
config.bind("<Ctrl-T>", "set-cmd-text -s :open -t")
config.bind("<Ctrl-Tab>", "tab-focus last")
config.bind("<Ctrl-b>", "open -t qute://tabs")
config.bind("<Ctrl-d>", "rl-delete-char", mode="command")
config.bind("<Ctrl-e>", "open-editor")
config.bind("<Ctrl-h>", "open -t qute://history")
config.bind("<Ctrl-r>", "config-source")
config.bind(
    "<Ctrl-s>", "open -t file:///home/piotr/.dotfiles/qtbro/qtb-search-helper.html"
)
config.bind("<Escape>", "leave-mode", mode="caret")
config.bind("<Escape>", "leave-mode", mode="passthrough")
config.bind("<F3>", "record-macro")
config.bind("<Return>", "yank selection", mode="caret")
config.bind("<Space>", "toggle-selection", mode="caret")
config.bind("<alt-p>", "enter-mode passthrough")
config.bind("=", "zoom-in")
config.bind("@", "run-macro")
config.bind("B", "set-cmd-text -s :buffer")
config.bind("C", ":enter-mode caret")
config.bind("F", "hint all tab")
config.bind("G", "move-to-end-of-document", mode="caret")
config.bind("G", "scroll bottom")
config.bind("H", "scroll left")
config.bind("I", "scroll up", mode="caret")
config.bind("J", "back")
config.bind("J", "scroll left", mode="caret")
config.bind("K", "scroll down", mode="caret")
config.bind("L", "scroll right")
config.bind("L", "scroll right", mode="caret")
config.bind("M", "set-cmd-text -s :bookmark-load -t")
config.unbind("O", "normal")
config.bind("Oc", "open -t {clipboard}")
config.bind("Op", "open -t {primary}")
config.bind("P", "open -p")
config.bind("Sm", "open -t ;; set-cmd-text -s :messages ;; command-accept")
config.bind("Y", "yank selection -s", mode="caret")
config.bind("[", "move-to-start-of-prev-block", mode="caret")
config.bind("]", "move-to-start-of-next-block", mode="caret")
config.bind("aA", "quickmark-del")
config.bind("aB", "bookmark-del")
config.bind("aa", "quickmark-save")
config.bind("ab", "bookmark-add")
config.bind("ap", "set-cmd-text :open -t https://getpocket.com/edit?url={url}")
config.bind("c", "enter-mode normal", mode="caret")
config.bind(
    "dA",
    'hint links fill :spawn st -c YTBDWL -e youtube-dl --extract-audio --audio-format mp3 --output "muz/qtb/%(title)s.%(ext)s" {hint-url}',
)
config.bind(
    "dE",
    'spawn st -c YTBDWL -e youtube-dl --write-srt --sub-lang en --output "wid/qtb/%(title)s.%(ext)s" {url}',
)
config.bind(
    "dS",
    'spawn st -c YTBDWL -e youtube-dl --write-auto-sub --skip-download --output "wid/qtb/%(title)s.%(ext)s" {url}',
)
config.bind(
    "dV",
    'hint links fill :spawn st -e youtube-dl --output "wid/qtb/%(title)s.%(ext)s" {hint-url}',
)
config.bind(
    "da",
    ':spawn st -c YTBDWL -e youtube-dl --extract-audio --audio-format mp3 --output "muz/qtb/%(title)s.%(ext)s" {url}',
)
config.bind(
    "ds",
    'spawn st -c YTBDWL -e youtube-dl --write-auto-sub --output "wid/qtb/%(title)s.%(ext)s" {url}',
)
config.bind("dv", 'spawn st -e youtube-dl --output "wid/qtb/%(title)s.%(ext)s" {url}')
config.bind("e", "enter-mode insert")
config.bind("e", "move-to-end-of-word", mode="caret")
config.bind("g;", "tab-move -1")
config.bind("gf", "view-source")
config.bind("gg", "move-to-start-of-document", mode="caret")
config.bind("gg", "scroll top")
config.bind("gh", "tab-move")
config.bind("gj", "tab-move -")
config.bind("gl", "tab-move +")
config.bind("go", "set-cmd-text :open {url:pretty}")
config.bind("gt", "set-cmd-text -s :buffer")
config.bind("gu", "navigate up")
config.bind("h", "back")
config.bind("h", "move-to-start-of-line", mode="caret")
config.bind("i", "move-to-prev-line", mode="caret")
config.bind("j", "move-to-prev-char", mode="caret")
config.bind("j", "scroll down")
config.bind("k", "move-to-next-line", mode="caret")
config.bind("k", "scroll up")
config.bind("l", "forward")
config.bind("l", "move-to-next-char", mode="caret")
config.bind("m", "set-cmd-text -s :quickmark-load -t")
config.bind("o", "move-to-next-word", mode="caret")
config.bind("q", "tab-close")
config.bind("sd", "session-save")
config.bind("sf", "save")
config.bind("sh", ":config-cycle statusbar.hide")
config.bind("st", ":config-cycle statusbar.position top bottom")
config.bind("tt", ":config-cycle tabs.show never multiple")
config.bind("u", "move-to-prev-word", mode="caret")
config.bind("v", "toggle-selection", mode="caret")
config.bind("W", "open -w")
config.bind("wB", "set-cmd-text -s :bookmark-load -w")
config.bind("wO", "set-cmd-text :open -w {url:pretty}")
config.bind("wP", "open -w -- {primary}")
config.bind("wb", "set-cmd-text -s :quickmark-load -w")
config.bind("wf", "hint all window")
config.bind("wh", "back -w")
config.bind("wi", "inspector")
config.bind("wl", "forward -w")
config.bind("wo", ":open -w {url}")
config.bind("wp", "open -w -- {clipboard}")
config.bind("ww", ":open -w")
config.bind("xO", "set-cmd-text :open -b -r {url:pretty}")
config.bind("xo", "set-cmd-text -s :open -b")
config.bind("y", "yank selection", mode="caret")
config.bind("{", "move-to-end-of-prev-block", mode="caret")
config.bind("}", "move-to-end-of-next-block", mode="caret")
config.unbind("<Ctrl-Q>", "normal")
config.unbind("<Ctrl-V>", "normal")
config.unbind("T", "normal")
config.unbind("d", "normal")
