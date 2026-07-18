o.exec_on_start("xfce-polkit")

o.exec_on_start("xdg-settings set default-web-browser app.zen_browser.zen.desktop")
o.exec_on_start("xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/http")
o.exec_on_start("xdg-mime default app.zen_browser.zen.desktop x-scheme-handler/https")
o.exec_on_start("xdg-mime default app.zen_browser.zen.desktop text/html")
