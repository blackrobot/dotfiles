# flake8: noqa
# fmt: off

##
# Configuration file for ipython.
##

c.InteractiveShellApp.exec_PYTHONSTARTUP = False

## A list of dotted module names of IPython extensions to load.
c.InteractiveShellApp.extensions = ["autoreload"]

## lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = [r"%autoreload 2"]

## Enable GUI event loop integration with any of ('asyncio', 'glut', 'gtk',
#  'gtk2', 'gtk3', 'osx', 'pyglet', 'qt', 'qt4', 'qt5', 'tk', 'wx', 'gtk2',
#  'qt4').
# c.InteractiveShellApp.gui = None

## Should variables loaded at startup (by startup files, exec_lines, etc.) be
#  hidden from tools like %who?
c.InteractiveShellApp.hide_initial_ns = True

## Whether to display a banner upon starting IPython.
c.TerminalIPythonApp.display_banner = True

## If a command or file is given via the command-line, e.g. 'ipython foo.py',
#  start an interactive shell after executing the file or command.
c.TerminalIPythonApp.force_interact = True

## Class to use to instantiate the TerminalInteractiveShell object. Useful for
#  custom Frontends
# c.TerminalIPythonApp.interactive_shell_class = 'IPython.terminal.interactiveshell.TerminalInteractiveShell'

## Automatically run await statement in the top level repl.
c.InteractiveShell.autoawait = True

## Autoindent IPython code entered interactively.
c.InteractiveShell.autoindent = True

## Enable magic commands to be called without the leading %.
# c.InteractiveShell.automagic = True

## The part of the banner to be printed before the profile
c.InteractiveShell.banner1 = (
    "Python 3.8.0 -- IPython 7.10.1\n"
    "Type '?' for help.\n"
)

## The part of the banner to be printed after the profile
# c.InteractiveShell.banner2 = ''

## Set the size of the output cache.  The default is 1000, you can change it
#  permanently in your config file.  Setting it to 0 completely disables the
#  caching system, and the minimum value accepted is 3 (if you provide a value
#  less than 3, it is reset to 0 and a warning is issued).  This limit is defined
#  because otherwise you'll spend more time re-flushing a too small cache than
#  working
# c.InteractiveShell.cache_size = 1000

## Use colors for displaying information about objects. Because this information
#  is passed through a pager (like 'less'), and some pagers get confused with
#  color codes, this capability can be turned off.
c.InteractiveShell.color_info = True

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
# c.InteractiveShell.colors = 'Neutral'

## Don't call post-execute functions that have failed in the past.
# c.InteractiveShell.disable_failing_post_execute = False

## Total length of command history
c.InteractiveShell.history_length = 10_000

## The number of saved history entries to be loaded into the history buffer at
#  startup.
c.InteractiveShell.history_load_length = 1_000

## Select the loop runner that will be used to execute top-level asynchronous
#  code
# c.InteractiveShell.loop_runner = 'IPython.core.interactiveshell._asyncio_runner'

##
# c.InteractiveShell.separate_in = '\n'
# c.InteractiveShell.separate_out = ''
# c.InteractiveShell.separate_out2 = ''

## Enables rich html representation of docstrings. (This requires the docrepr
#  module).
c.InteractiveShell.sphinxify_docstring = True

##
# c.InteractiveShell.wildcards_case_sensitive = True

## Autoformatter to reformat Terminal code. Can be `'black'` or `None`
c.TerminalInteractiveShell.autoformatter = "black"

## Set to confirm when you try to exit IPython with an EOF (Control-D in Unix,
#  Control-Z/Enter in Windows). By typing 'exit' or 'quit', you can force a
#  direct exit without any confirmation.
c.TerminalInteractiveShell.confirm_exit = False

## Options for displaying tab completions, 'column', 'multicolumn', and
#  'readlinelike'. These options are for `prompt_toolkit`, see `prompt_toolkit`
#  documentation for more information.
c.TerminalInteractiveShell.display_completions = "multicolumn"

## Shortcut style to use at the prompt. 'vi' or 'emacs'.
c.TerminalInteractiveShell.editing_mode = "vi"

## Set the editor used by IPython (default to $EDITOR/vi/notepad).
c.TerminalInteractiveShell.editor = "code --wait"

## Allows to enable/disable the prompt toolkit history search
c.TerminalInteractiveShell.enable_history_search = True

## Enable vi (v) or Emacs (C-X C-E) shortcuts to open an external editor. This is
#  in addition to the F2 binding, which is always enabled.
c.TerminalInteractiveShell.extra_open_editor_shortcuts = True

## Highlight matching brackets.
c.TerminalInteractiveShell.highlight_matching_brackets = True

## The name or class of a Pygments style to use for syntax highlighting. To see
#  available styles, run `pygmentize -L styles`.
# c.TerminalInteractiveShell.highlighting_style = traitlets.Undefined
c.TerminalInteractiveShell.highlighting_style = "native"

## Enable mouse support in the prompt (Note: prevents selecting text with the
#  mouse)
c.TerminalInteractiveShell.mouse_support = False

## Display the current vi mode (when using vi editing mode).
c.TerminalInteractiveShell.prompt_includes_vi_mode = True

## Class used to generate Prompt token for prompt_toolkit
# c.TerminalInteractiveShell.prompts_class = 'IPython.terminal.prompts.Prompts'

## Number of line at the bottom of the screen to reserve for the completion menu
c.TerminalInteractiveShell.space_for_menu = 6

## Automatically set the terminal title
c.TerminalInteractiveShell.term_title = True

## Customize the terminal title format.  This is a python format string.
#  Available substitutions are: {cwd}.
# c.TerminalInteractiveShell.term_title_format = 'IPython: {cwd}'

## Use 24bit colors instead of 256 colors in prompt highlighting. If your
#  terminal supports true color, the following command should print 'TRUECOLOR'
#  in orange: printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
c.TerminalInteractiveShell.true_color = True

## enable the SQLite history
#
#  set enabled=False to disable the SQLite history, in which case there will be
#  no stored history, no SQLite connection, and no background saving thread.
#  This may be necessary in some threaded environments where IPython is embedded.
c.HistoryAccessor.enabled = True

## Path to file to use for SQLite history database.
#
#  By default, IPython will put the history database in the IPython profile
#  directory.  If you would rather share one history among profiles, you can set
#  this value in each, so that they are consistent.
#
#  Due to an issue with fcntl, SQLite is known to misbehave on some NFS mounts.
#  If you see IPython hanging, try setting this to something on a local disk,
#  e.g::
#
#      ipython --HistoryManager.hist_file=/tmp/ipython_hist.sqlite
#
#  you can also use the specific value `:memory:` (including the colon at both
#  end but not the back ticks), to avoid creating an history file.
# c.HistoryAccessor.hist_file = ''

## Write to database every x commands (higher values save disk access & power).
#  Values of 1 or less effectively disable caching.
# c.HistoryManager.db_cache_size = 0
c.HistoryManager.db_cache_size = 3

## Should the history database include output? (default: no)
c.HistoryManager.db_log_output = False

## Enable unicode completions, e.g. \alpha<tab> . Includes completion of latex
#  commands, unicode names, and expanding unicode characters back to latex
#  commands.
c.Completer.backslash_combining_completions = True

## Enable debug for the Completer. Mostly print extra information for
#  experimental jedi integration.
# c.Completer.debug = False

## Activate greedy completion PENDING DEPRECTION. this is now mostly taken care
#  of with Jedi.
#
#  This will enable completion on elements of lists, results of function calls,
#  etc., but can be unsafe because the code is actually evaluated on TAB.
# c.Completer.greedy = False

## Experimental: restrict time (in milliseconds) during which Jedi can compute
#  types. Set to 0 to stop computing types. Non-zero value lower than 100ms may
#  hurt performance by preventing jedi to build its cache.
c.Completer.jedi_compute_type_timeout = 400

## Experimental: Use Jedi to generate autocompletions. Default to True if jedi is
#  installed.
c.Completer.use_jedi = True

## Whether to merge completion results into a single list
#
#  If False, only the completion results from the first non-empty completer will
#  be returned.
c.IPCompleter.merge_completions = True

## Instruct the completer to omit private method names
#
#  Specifically, when completing on ``object.<tab>``.
#
#  When 2 [default]: all names that start with '_' will be excluded.
#
#  When 1: all 'magic' names (``__foo__``) will be excluded.
#
#  When 0: nothing will be excluded.
c.IPCompleter.omit__names = 0
