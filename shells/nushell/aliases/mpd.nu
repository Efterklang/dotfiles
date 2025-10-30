# music player

def start_mpd [] {
    if (pgrep mpd | is-empty) {
        print "[INFO] Starting MPD..."
        mpd ~/.config/mpd/mpd.conf
    } else {
        print "[INFO] MPD is already running."
    }

    # 等待mpd socket可用
    mut retries = 5
    while $retries > 0 {
        if (mpc status | complete | get exit_code) == 0 {
            break
        }
        sleep 500ms
        $retries = ($retries - 1)
    }

    if $retries == 0 {
        print "[ERROR] MPD did not respond after waiting."
        return
    }

    print "[INFO] MPD started. Initializing queue..."
    let added = (mpc listall | mpc add | complete)
    if $added.exit_code == 0 {
        print "[INFO] Queue initialized."
    } else {
        print $"[ERROR] Error adding songs: ($added.stderr)"
    }

    # integrate with macOS Now Playing widget if available
    if (which mpd-now-playable | is-empty) == false and ($nu.os-info.name == "macos") {
      if (ps -l | where command ends-with "mpd-now-playable" | is-empty) {
          print "[INFO] Starting mpd-now-playable for Now Playing widget integration..."
          zsh -lc "mpd-now-playable > /dev/null 2>&1 &"
          return
      } else {
          print "[INFO] mpd-now-playable is already running."
      }
    }
}
