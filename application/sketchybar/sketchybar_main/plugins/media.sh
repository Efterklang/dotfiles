#!/usr/bin/env python

import subprocess
import os
import json
from time import sleep


def fmt_msg(msg, length):
    return f"{msg:.{length - 1}}…" if len(msg) > length else msg


def kill_dupes(proc_str):
    current_process = os.getpid()
    processes = subprocess.run(["pgrep", "-f", proc_str], capture_output=True, text=True)
    for process in processes.stdout.splitlines():
        if process != current_process:
            subprocess.run(["kill", "-9", process])


def get_media_info():
    return json.loads(os.environ.get("INFO")) if os.environ.get("INFO") else exit(0)


def main():
    kill_dupes("/sketchybar/plugins/media.sh")
    media_info = get_media_info()
    if media_info["state"] not in ["playing", "paused"]:
        exit(0)

    now_playing = f"{media_info['title']} - {media_info['artist']}"
    print(fmt_msg(now_playing, 30))
    sleep(2)

    marquee = f"{now_playing}     {now_playing}"
    marquee_len = min(len(now_playing), 30)
    # + 6 is 5 spaces + 1 more ittr to get back to beginning
    for i in range(len(now_playing) + 7):
        if i == 1:
            display = f"…{marquee[i:]:.{marquee_len - 1}}"
        elif i > 1 and i < len(now_playing) + 5:
            display = f"…{marquee[i:]:.{marquee_len - 2}}…"
        elif i == len(now_playing) + 5:
            display = f"{marquee[i:]:.{marquee_len - 1}}…"
        else:
            display = fmt_msg(now_playing, 30)

        subprocess.run(
            [
                "sketchybar",
                "--set",
                os.environ.get("NAME"),
                'icon=󰲑',
                "drawing=on",
                f"label={display}",
            ],
            capture_output=True,
            text=True,
        )
        print(display, len(display))
        sleep(0.15)
main()