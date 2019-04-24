# flake8: noqa

import importlib
import sys


def import_to_namespace(name, package=None, alias=None):
    if not alias:
        alias = name.partition(".")[0]
    sys.modules[alias] = importlib.import_module(name, package=package)
    globals()[alias] = sys.modules[alias]


modules_to_import = (
    ("datetime", None, "dt"),
    ("pathlib",),
    ("os",),
)


for import_args in modules_to_import:
    import_to_namespace(*import_args)


print("\n* imported: {}\n".format(", ".join(x for x, *_ in modules_to_import)))


# cleanup
del import_to_namespace, modules_to_import, importlib

