# flake8: noqa

import datetime
import importlib
import os
import pathlib
import sys


dt = datetime


class setup:
    PYTHON = "PYTHON"
    PTPYTHON = "PTPYTHON"
    IPYTHON = "IPYTHON"
    PTIPYTHON = "PTIPYTHON"
    UNKNOWN = "UNKNOWN"

    interpreters = (PYTHON, PTPYTHON, IPYTHON, PTIPYTHON)

    def __init__(self):
        if self.interpreter in (self.PYTHON, self.UNKNOWN):
            self.setup_plain_python()

    @property
    def interpreter(self):
        prog_name = pathlib.Path(sys.argv[0]).stem.upper()
        if prog_name in self.interpreters:
            return prog_name
        return self.UNKNOWN

    def log(self, message, indent="  ", prefix="## "):
        print(f"{prefix}{indent}{message}")

    def setup_plain_python(self):
        print("")

        self.log("+ configuring plain python terminal", indent="")

        import readline
        import rlcompleter

        try:
            from jedi.utils import setup_readline
            setup_readline()
            self.log("- setup jedi autocomplete")
        except ImportError:
            self.log("- failed to load jedi, falling back to readline")
            readline.parse_and_bind("tab: complete")

        # History log
        history_file = pathlib.Path("~/.python_history").expanduser()
        history_file.touch()

        def save_history(path=history_file):
            import readline
            readline.write_history_file(path)

        def load_history(path=history_file):
            try:
                readline.read_history_file(path)
                self.log("- loaded history from ~/.python_history")
            except Exception:
                self.log("- failed to load history from ~/.python_history")

        load_history()

        import atexit
        atexit.register(save_history)

        print("", flush=True)


setup.instance = setup()
del setup
