#!/usr/bin/env bash

# 优化后的图标映射 - 使用关联数组提高性能
declare -A app_icons=(
  # AI
  ["ChatGPT"]=":openai:"

  # Office 办公
  ["Canary Mail"]=":mail:" ["HEY"]=":mail:" ["Mail"]=":mail:"
  ["Microsoft Outlook"]=":mail:" ["MailMate"]=":mail:" ["邮件"]=":mail:" ["Outlook"]=":mail:"
  ["Matlab"]=":matlab:"
  ["Microsoft Excel"]=":microsoft_excel:"
  ["Microsoft PowerPoint"]=":microsoft_power_point:"
  ["Numbers"]=":numbers:"
  ["Microsoft Word"]=":microsoft_word:"
  ["Microsoft Teams"]=":microsoft_teams:"
  ["Pages"]=":pages:"

  # Browser
  ["Arc"]=":arc:" ["Vivaldi"]=":arc:"
  ["Chromium"]=":google_chrome:" ["Google Chrome"]=":google_chrome:" ["Google Chrome Canary"]=":google_chrome:"
  ["Firefox"]=":firefox:"
  ["Microsoft Edge"]=":microsoft_edge:" ["Microsoft Edge Dev"]=":microsoft_edge:"
  ["Firefox Developer Edition"]=":firefox_developer_edition:" ["Firefox Nightly"]=":firefox_developer_edition:"
  ["Brave Browser"]=":brave_browser:"
  ["Tor Browser"]=":tor_browser:"
  ["Safari"]=":safari:" ["Safari浏览器"]=":safari:" ["Safari Technology Preview"]=":safari:"

  # Chats
  ["Discord"]=":discord:" ["Discord Canary"]=":discord:" ["Discord PTB"]=":discord:"
  ["Telegram"]=":telegram:"
  ["QQ"]=":qq:"
  ["微信"]=":wechat:" ["WeChat"]=":wechat:"

  # Media
  ["Spotify"]=":spotify:"
  ["Music"]=":music:" ["NetEaseMusic"]=":music:" ["LX Music"]=":music:"
  ["网易云音乐"]=":netease_music:" ["tauonmb"]=":netease_music:"

  # Editor
  ["Typora"]=":text:"
  ["Atom"]=":atom:"
  ["Obsidian"]=":obsidian:"
  ["Code"]=":code:" ["Code - Insiders"]=":code:"
  ["VSCodium"]=":vscodium:"
  ["PyCharm"]=":pycharm:"
  ["IntelliJ IDEA"]=":idea:"
  ["Neovide"]=":vim:" ["MacVim"]=":vim:" ["Vim"]=":vim:" ["VimR"]=":vim:"
  ["Emacs"]=":emacs:"

  # Terminal
  ["Alacritty"]=":alacritty:" ["Hyper"]=":terminal:" ["Ghostty"]=":ghostty:"
  ["iTerm2"]=":terminal:" ["kitty"]=":terminal:" ["Terminal"]=":terminal:" ["WezTerm"]=":terminal:"

  # MacOS Apps
  ["Activity Monitor"]=":cpu:"
  ["Finder"]=":finder:" ["访达"]=":finder:"
  ["Spotlight"]=":spotlight:"
  ["Keynote"]=":keynote:"
  ["Xcode"]=":xcode:"
  ["App Store"]=":app_store:"
  ["System Preferences"]=":gear:" ["System Settings"]=":gear:"
  ["Font Book"]=":book:" # TODO

  # Developer
  ["OrbStack"]=":orbstack:"
  ["GitHub Desktop"]=":git_hub:"
  ["Android Studio"]=":android_studio:"
  ["WebStorm"]=":web_storm:"
  ["Sublime Text"]=":sublime_text:"

  # Multimedia
  ["VLC"]=":vlc:"
  ["Final Cut Pro"]=":final_cut_pro:"
  ["OBS"]=":obsstudio:"
  ["Blender"]=":blender:"
  ["Figma"]=":figma:"
  ["Sketch"]=":sketch:"

  # Entertainment
  ["Steam Helper"]="steam" ["Steam"]=":steam:"

  # Other
  ["Raycast"]=":raycast:"
  ["Bitwarden"]=":bit_warden:"
  ["Dropbox"]=":dropbox:"
  ["Notion"]=":notion:"
  ["Bear"]=":bear:"
  ["Notes"]=":notes:"
  ["Calendar"]=":calendar:" ["Fantastical"]=":calendar:"
  ["Preview"]=":pdf:" ["Skim"]=":pdf:" ["zathura"]=":pdf:" ["sioyek"]=":pdf:"
)

input_app="$@"
icon_result=${app_icons["$input_app"]:-":default:"}
echo $icon_result