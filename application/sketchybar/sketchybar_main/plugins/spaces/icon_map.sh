case $@ in
# AI
"ChatGPT")
  icon_result=":openai:"
  ;;
# Office 办公
"Canary Mail" | "HEY" | "Mail" | "Microsoft Outlook" | "MailMate" | "邮件" | "Outlook")
  icon_result=":mail:"
  ;;
"Matlab")
  icon_result=":matlab:"
  ;;
"Microsoft Excel")
  icon_result=":microsoft_excel:"
  ;;
"Microsoft PowerPoint")
  icon_result=":microsoft_power_point:"
  ;;
"Numbers")
  icon_result=":numbers:"
  ;;
"Microsoft Word")
  icon_result=":microsoft_word:"
  ;;
"Microsoft Teams")
  icon_result=":microsoft_teams:"
  ;;
# Browser
"Arc" | "Vivaldi")
  icon_result=":arc:"
  ;;
"Chromium" | "Google Chrome" | "Google Chrome Canary")
  icon_result=":google_chrome:"
  ;;
"Firefox")
  icon_result=":firefox:"
  ;;
"Microsoft Edge")
  icon_result=":microsoft_edge:"
  ;;
"Firefox Developer Edition" | "Firefox Nightly")
  icon_result=":firefox_developer_edition:"
  ;;
"Brave Browser")
  icon_result=":brave_browser:"
  ;;
"Tor Browser")
  icon_result=":tor_browser:"
  ;;
"Safari" | "Safari浏览器" | "Safari Technology Preview")
  icon_result=":safari:"
  ;;
# Chats
"Discord" | "Discord Canary" | "Discord PTB")
  icon_result=":discord:"
  ;;
"Telegram")
  icon_result=":telegram:"
  ;;
"QQ")
  icon_result=":qq:"
  ;;
"微信" | "WeChat")
  icon_result=":wechat:"
  ;;
# Media
"Spotify")
  icon_result=":spotify:"
  ;;
"Music" | "NetEaseMusic" | "LX Music")
  icon_result=":music:"
  ;;
"网易云音乐" | "tauonmb")
  icon_result=":netease_music:"
  ;;
# Editor
"Typora")
  icon_result=":text:"
  ;;
"Atom")
  icon_result=":atom:"
  ;;
"Obsidian")
  icon_result=":obsidian:"
  ;;
"Code" | "Code - Insiders")
  icon_result=":code:"
  ;;
"VSCodium")
  icon_result=":vscodium:"
  ;;
"PyCharm")
  icon_result=":pycharm:"
  ;;
"IntelliJ IDEA")
  icon_result=":idea:"
  ;;
"Neovide" | "MacVim" | "Vim" | "VimR")
  icon_result=":vim:"
  ;;
"Emacs")
  icon_result=":emacs:"
  ;;
# VPN
"Clash Verge")
  icon_result=":nord_vpn:"
  ;;
# MacOs Apps
"Activity Monitor")
  icon_result=":cpu:"
  ;;
"Finder" | "访达")
  icon_result=":finder:"
  ;;
"Spotlight")
  icon_result=":spotlight:"
  ;;
"Keynote")
  icon_result=":keynote:"
  ;;
"Xcode")
  icon_result=":xcode:"
  ;;
"App Store")
  icon_result=":app_store:"
  ;;
# Developer
"Alacritty" | "Hyper" | "Ghostty" | "iTerm2" | "kitty" | "Terminal" | "WezTerm")
  icon_result=":terminal:"
  ;;
"OrbStack")
  icon_result=":orbstack:"
  ;;
# ------ MISC
"Keyboard Maestro")
  icon_result=":keyboard_maestro:"
  ;;
"Min")
  icon_result=":min_browser:"
  ;;
"Final Cut Pro")
  icon_result=":final_cut_pro:"
  ;;
"FaceTime")
  icon_result=":face_time:"
  ;;
"Affinity Publisher")
  icon_result=":affinity_publisher:"
  ;;
"Messages" | "Nachrichten")
  icon_result=":messages:"
  ;;
"Tweetbot" | "Twitter")
  icon_result=":twitter:"
  ;;
"ClickUp")
  icon_result=":click_up:"
  ;;
"KeePassXC")
  icon_result=":kee_pass_x_c:"
  ;;
"VLC")
  icon_result=":vlc:"
  ;;
"Thunderbird")
  icon_result=":thunderbird:"
  ;;
"Notes")
  icon_result=":notes:"
  ;;
"Caprine")
  icon_result=":caprine:"
  ;;
"Zulip")
  icon_result=":zulip:"
  ;;
"Spark")
  icon_result=":spark:"
  ;;
"Microsoft To Do" | "Things")
  icon_result=":things:"
  ;;
"DEVONthink 3")
  icon_result=":devonthink3:"
  ;;
"GitHub Desktop")
  icon_result=":git_hub:"
  ;;
"zoom.us")
  icon_result=":zoom:"
  ;;
"MoneyMoney")
  icon_result=":bank:"
  ;;
"Color Picker")
  icon_result=":color_picker:"
  ;;
"Iris")
  icon_result=":iris:"
  ;;
"WebStorm")
  icon_result=":web_storm:"
  ;;
"Sublime Text")
  icon_result=":sublime_text:"
  ;;
"PomoDone App")
  icon_result=":pomodone:"
  ;;
"Setapp")
  icon_result=":setapp:"
  ;;
"qutebrowser")
  icon_result=":qute_browser:"
  ;;
"Mattermost")
  icon_result=":mattermost:"
  ;;
"Notability")
  icon_result=":notability:"
  ;;
"WhatsApp")
  icon_result=":whats_app:"
  ;;
"OBS")
  icon_result=":obsstudio:"
  ;;
"Parallels Desktop")
  icon_result=":parallels:"
  ;;
"VMware Fusion")
  icon_result=":vmware_fusion:"
  ;;
"Pine")
  icon_result=":pine:"
  ;;
"Default")
  icon_result=":default:"
  ;;
"Element")
  icon_result=":element:"
  ;;
"Bear")
  icon_result=":bear:"
  ;;
"TeamSpeak 3")
  icon_result=":team_speak:"
  ;;
"Airmail")
  icon_result=":airmail:"
  ;;
"Trello")
  icon_result=":trello:"
  ;;
"TickTick")
  icon_result=":tick_tick:"
  ;;
"Notion")
  icon_result=":notion:"
  ;;
"Live")
  icon_result=":ableton:"
  ;;
"Evernote Legacy")
  icon_result=":evernote_legacy:"
  ;;
"Calendar" | "Fantastical")
  icon_result=":calendar:"
  ;;
"Android Studio")
  icon_result=":android_studio:"
  ;;
"Slack")
  icon_result=":slack:"
  ;;
"Sequel Pro")
  icon_result=":sequel_pro:"
  ;;
"Bitwarden")
  icon_result=":bit_warden:"
  ;;
"System Preferences" | "System Settings")
  icon_result=":gear:"
  ;;
"Skype")
  icon_result=":skype:"
  ;;
"Dropbox")
  icon_result=":dropbox:"
  ;;
"Blender")
  icon_result=":blender:"
  ;;
"Reeder")
  icon_result=":reeder5:"
  ;;
"MAMP" | "MAMP PRO")
  icon_result=":mamp:"
  ;;
"Figma")
  icon_result=":figma:"
  ;;
"Joplin")
  icon_result=":joplin:"
  ;;
"Steam Helper")
  icon_result="󰓓"
  ;;
"Parsec")
  icon_result="󱣵"
  ;;
"Insomnia")
  icon_result=":insomnia:"
  ;;
"TIDAL")
  icon_result=":tidal:"
  ;;
"Alfred")
  icon_result=":alfred:"
  ;;
"Pages")
  icon_result=":pages:"
  ;;
"Folx")
  icon_result=":folx:"
  ;;
"Android Messages")
  icon_result=":android_messages:"
  ;;
"mpv")
  icon_result=":mpv:"
  ;;
"Transmit")
  icon_result=":transmit:"
  ;;
"Pi-hole Remote")
  icon_result=":pihole:"
  ;;
"Nova")
  icon_result=":nova:"
  ;;
"Affinity Designer")
  icon_result=":affinity_designer:"
  ;;
"Drafts")
  icon_result=":drafts:"
  ;;
"Audacity")
  icon_result=":audacity:"
  ;;
"Affinity Photo")
  icon_result=":affinity_photo:"
  ;;
"CleanMyMac X")
  icon_result=":desktop:"
  ;;
"Zotero")
  icon_result=":zotero:"
  ;;
"Todoist")
  icon_result=":todoist:"
  ;;
"LibreWolf")
  icon_result=":libre_wolf:"
  ;;
"Grammarly Editor")
  icon_result=":grammarly:"
  ;;
"OmniFocus")
  icon_result=":omni_focus:"
  ;;
"Reminders")
  icon_result=":reminders:"
  ;;
"Preview" | "Skim" | "zathura" | "sioyek")
  icon_result=":pdf:"
  ;;
"1Password 7")
  icon_result=":one_password:"
  ;;
"Tower")
  icon_result=":tower:"
  ;;
"Calibre")
  icon_result=":book:"
  ;;
"Linear")
  icon_result=":linear:"
  ;;
"League of Legends")
  icon_result=":league_of_legends:"
  ;;
"Zeplin")
  icon_result=":zeplin:"
  ;;
"Signal")
  icon_result=":signal:"
  ;;
"Podcasts")
  icon_result=":podcasts:"
  ;;
"Kakoune")
  icon_result=":kakoune:"
  ;;
"GrandTotal" | "Receipts")
  icon_result=":dollar:"
  ;;
"Sketch")
  icon_result=":sketch:"
  ;;
"Sequel Ace")
  icon_result=":sequel_ace:"
  ;;
*)
  icon_result=":default:"
  ;;
esac
echo $icon_result
