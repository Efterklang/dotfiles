"""Tmux-style border-direction resize for kitty (no-UI custom kitten).

Usage:
    map ... kitten kitty-tmux-resize.py {left|right|up|down} [amount]

hjkl describes which direction the border between the active window and
a neighbor should visually move. Whether that grows or shrinks the active
window depends on which side of the border it sits on — same semantics
as tmux's resize-pane.
"""

from __future__ import annotations

from kittens.tui.handler import result_handler
from kitty.boss import Boss

_NEIGHBOR = {
    "left": "left",
    "right": "right",
    "up": "top",
    "down": "bottom",
}


def main(args: list[str]) -> str:
    return ""


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    if len(args) < 2:
        return
    direction = args[1]
    amount = int(args[2]) if len(args) > 2 else 5

    neighbor_dir = _NEIGHBOR.get(direction)
    if neighbor_dir is None:
        return

    tab = boss.active_tab
    if tab is None:
        return
    windows = tab.windows
    aw = windows.active_window
    if aw is None:
        return

    nmap = tab.current_layout.neighbors_for_window(aw, windows)
    has_neighbor = bool(nmap.get(neighbor_dir))

    if direction in ("left", "right"):
        quality = "wider" if has_neighbor else "narrower"
    else:
        quality = "taller" if has_neighbor else "shorter"

    tab.resize_window(quality, amount)
