# flake8: noqa
# Configuration file for jupyter-console.

c.JupyterConsoleApp.confirm_exit = False
# c.JupyterConsoleApp.existing = ''

c.ZMQTerminalInteractiveShell.banner = 'Jupyter console {version}\n\n{kernel_banner}'
c.ZMQTerminalInteractiveShell.editing_mode = 'vi'
c.ZMQTerminalInteractiveShell.highlight_matching_brackets = True

##
# To see a list of styles run:
#   python -c '
#   from pygments.styles import get_all_styles as S;
#   print(*sorted(S()), sep="\n")
#   '
##
c.ZMQTerminalInteractiveShell.highlighting_style = "native"

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
c.ZMQTerminalInteractiveShell.true_color = True
