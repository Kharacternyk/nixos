#!@python@ -I

import getpass
import hashlib
import json
import os
import socket
import subprocess
import sys


def main():
    arguments = sys.argv[1:]
    runtime = os.environ.get("XDG_RUNTIME_DIR")
    if runtime:
        username = getpass.getuser().encode("utf-8")
        digest = hashlib.md5(username, usedforsecurity=False).hexdigest()
        address = os.path.join(runtime, "qutebrowser", f"ipc-{digest}")
        message = {
            "args": arguments,
            "protocol_version": 1,
            "target_arg": None,
            "version": "@version@",
        }
        try:
            message["cwd"] = os.getcwd()
        except OSError:
            pass

        try:
            with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as ipc:
                ipc.settimeout(1)
                ipc.connect(address)
                ipc.sendall((json.dumps(message) + "\n").encode("utf-8"))
            return
        except OSError:
            pass

    subprocess.Popen(
        ["@qutebrowser@", "-C", "@config@", *arguments],
        start_new_session=True,
    )


if __name__ == "__main__":
    main()
