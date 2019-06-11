"""
The example configuration used can be found here: https://git.io/fjgyb
"""

from __future__ import unicode_literals
import os

from ptpython.layout import CompletionVisualisation


__all__ = ["configure"]


# True if interpreter is running inside of a Vim/NeoVim instance
inside_of_vim = os.getenv("VIMRUNTIME", False)

# Color Depths:
#    1 = "DEPTH_1_BIT"
#    4 = "DEPTH_4_BIT"
#    8 = "DEPTH_8_BIT"
#   24 = "DEPTH_24_BIT"  ->  Can't get truecolor to work properly :(
color_depth = "DEPTH_8_BIT"


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.

    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = False

    # Show docstring (bool).
    repl.show_docstring = True

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = False

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.MULTI_COLUMN

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = True

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Complete while typing. (Don't require tab before the completion
    # menu is shown.). See `repl.enable_history_search`...
    repl.complete_while_typing = True

    # Mouse support.
    repl.enable_mouse_support = False

    # Vi mode.
    repl.vi_mode = True

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = "classic"  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = False

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = not repl.complete_while_typing

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = True

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    # Only if not running inside of a neovim window
    repl.enable_open_in_editor = not inside_of_vim

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = False

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Use this colorscheme for the code.
    # repl.use_code_colorscheme('monokai')
    repl.use_code_colorscheme("native")

    # Enable 24bit True color. (Not all terminals support this. -- maybe check
    # $TERM before changing.)
    repl.color_depth = color_depth

    repl.enable_syntax_highlighting = True
