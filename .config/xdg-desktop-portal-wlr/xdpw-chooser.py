"""
BSD Zero Clause License

Copyright (C) 2026 by CToID <funk443@icloud.com>

Permission to use, copy, modify, and/or distribute this software
for any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
"""

import json
import subprocess
import sys


MONITOR = "Monitor"
WINDOW = "Window"


def get_outputs(outputs: list) -> list[str]:
    return [output["name"] for output in outputs]


def get_windows(root: dict) -> list[str]:
    def extract_nodes(node):
        return node["nodes"]

    windows = []
    not_done = extract_nodes(root)
    while not_done:
        it = not_done.pop()
        if "foreign_toplevel_identifier" in it:
            name = it["name"]
            identifier = it["foreign_toplevel_identifier"]
            windows.append(" ".join([identifier, name]))
            continue

        not_done += extract_nodes(it)

    return windows


if __name__ == "__main__":
    capture_type_result = subprocess.run(
        ["wmenu", "-l", "5", "-p", "Capture type: "],
        input="\n".join([MONITOR, WINDOW]),
        capture_output=True,
        text=True,
    )
    if capture_type_result.returncode != 0:
        print(f"FATAL: wmenu returned non-zero exit status.", file=sys.stderr)
        sys.exit(capture_type_result.returncode)

    capture_type = capture_type_result.stdout.strip()
    command_to_run = [
        "swaymsg", "-r", "-t",
    ]
    if capture_type == MONITOR:
        command_to_run.append("get_outputs")
    elif capture_type == WINDOW:
        command_to_run.append("get_tree")
    else:
        print(f"FATAL: Invalid capture type: {capture_type}", file=sys.stderr)
        sys.exit(1)

    swaymsg_result = subprocess.run(
        command_to_run,
        capture_output=True,
        text=True,
    )
    if swaymsg_result.returncode != 0:
        print(f"FATAL: swaymsg returned non-zero exit status.", file=sys.stderr)
        sys.exit(swaymsg_result.returncode)

    candidates = json.loads(swaymsg_result.stdout)
    if capture_type == MONITOR:
        selections = "\n".join(get_outputs(candidates))
    else:
        selections = "\n".join(get_windows(candidates))

    selection_result = subprocess.run(
        ["wmenu", "-l", "5", "-p", "Thing to capture: "],
        input=selections,
        capture_output=True,
        text=True,
    )
    if selection_result.returncode != 0:
        print(f"FATAL: wmenu returned non-zero exit status.", file=sys.stderr)
        sys.exit(selection_result.returncode)

    selection = selection_result.stdout.strip()
    if capture_type == WINDOW:
        selection, _, _ = selection.partition(" ")

    print(f"{capture_type}: {selection}", end="")
