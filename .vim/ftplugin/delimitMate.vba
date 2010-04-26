" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
doc/delimitMate.txt	[[[1
561
*delimitMate*    Trying to keep those beasts at bay! v.2.0   *delimitMate.txt*

  =========================================================================  ~
  ====  =========  ==========================  =====  =====================  ~
  ====  =========  ==========================   ===   =====================  ~
  ====  =========  =====================  ===  =   =  ==========  =========  ~
  ====  ===   ===  ==  ==  =  = ===  ==    ==  == ==  ===   ===    ===   ==  ~
  ==    ==  =  ==  ======        =======  ===  =====  ==  =  ===  ===  =  =  ~
  =  =  ==     ==  ==  ==  =  =  ==  ===  ===  =====  =====  ===  ===     =  ~
  =  =  ==  =====  ==  ==  =  =  ==  ===  ===  =====  ===    ===  ===  ====  ~
  =  =  ==  =  ==  ==  ==  =  =  ==  ===  ===  =====  ==  =  ===  ===  =  =  ~
  ==    ===   ===  ==  ==  =  =  ==  ===   ==  =====  ===    ===   ===   ==  ~
  =========================================================================  ~

                              REFERENCE MANUAL                               *

==============================================================================
 0.- CONTENTS                                           *delimitMate-contents*

    1. Introduction____________________________|delimitMateIntro|
    2. Functionality___________________________|delimitMateFunctionality|
        2.1 Automatic closing & exiting________|delimitMateAutoClose|
        2.2 Expansion of space and CR__________|delimitMateExpansion|
        2.3 Backspace__________________________|delimitMateBackspace|
        2.4 Visual wrapping____________________|delimitMateVisualWrapping|
        2.5 Smart Quotes_______________________|delimitMateSmartQuotes|
    3. Customization___________________________|delimitMateOptions|
        3.1 Option summary_____________________|delimitMateOptionSummary|
        3.2 Options details____________________|delimitMateOptionDetails|
    4. Commands________________________________|delimitMateCommands|
    5. Functions_______________________________|delimitMateFunctions|
    6. TODO list_______________________________|delimitMateTodo|
    7. Maintainer______________________________|delimitMateMaintainer|
    8. Credits_________________________________|delimitMateCredits|
    9. History_________________________________|delimitMateHistory|

==============================================================================
 1.- INTRODUCTION                                           *delimitMateIntro*

The delimitMate plugin tries to provide some not so dumb help in the work with
delimiters (brackets, quotes, etc.), with some optional auto-completions and
expansions.

When automatic closing is enabled, if an opening delimiter is inserted
delimitMate inserts the closing pair and places the cursor between them. When
automatic closing is disabled, no closing delimiters is inserted by
delimitMate, but if a pair of delimiters is typed, the cursor is placed in the
middle. Also, to get out of a pair of delimiters just type shift+tab or the
right delimiter and the cursor will jump to the right.

If the cursor is inside an empty pair of delimiters, typing <Space> will
insert two spaces and the cursor will be placed in the middle; typing <CR>
will insert to car retunrs and place the cursor in the middle line, between
the delimiters.

All of the operations are undo/redo-wise safe.

==============================================================================
 2. FUNCTIONALITY                                   *delimitMateFunctionality*

------------------------------------------------------------------------------
   2.1 AUTOMATIC CLOSING AND EXITING                    *delimitMateAutoClose*

With automatic closing enabled, if an opening delimiter is inserted the plugin
inserts the closing delimiter and places the cursor between the pair. With
automatic closing disabled, no closing delimiters is inserted by delimitMate,
but when a pair of delimiters is typed, the cursor is placed in the middle.

When the cursor is inside an empty pair or located next to the left of a
closing delimiter, the cursor is placed outside the pair to the right of the
closing delimiter.

Unless |'delimitMate_matchpairs'| or |'delimitMate_quotes'|are set, this
script uses the values in '&matchpairs' to identify the pairs, and ", ' and `
for quotes respectively.

The following table shows the behaviour, this applies to quotes too (the final
position of the cursor is represented by a "|"):

With auto-close: >
                          Type   |  You get
                        ====================
                           (     |    (|)
                        –––––––––|––––––––––
                           ()    |    ()|
                        –––––––––|––––––––––
                        (<S-Tab> |    ()|
<
Without auto-close: >

                          Type    |  You get
                        =====================
                           ()     |    (|)
                        –––––––––-|––––––––––
                           ())    |    ()|
                        –––––––––-|––––––––––
                        ()<S-Tab> |    ()|
<
------------------------------------------------------------------------------
   2.2 EXPANSION OF SPACE AND CAR RETURN                *delimitMateExpansion*

When the cursor is inside an empty pair of delimiters, <Space> and <CR> can be
expanded, see |'delimitMate_expand_space'| and
|'delimitMate_expand_cr'|:

Expand <Space> to: >

                    <Space><Space><Left>  |  You get
                  ====================================
                              (|)         |    ( | )
<
Expand <CR> to: >

                      <CR><CR><Up>  |  You get
                    ============================
                           (|)      |    (
                                    |    |
                                    |    )
<

Since <Space> and <CR> are used everywhere, I have made the functions involved
in expansions global, so they can be used to make custom mappings. Read
|delimitMateFunctions| for more details.

------------------------------------------------------------------------------
   2.3 BACKSPACE                                        *delimitMateBackspace*

If you press backspace inside an empty pair, both delimiters are deleted. If
you type shift + backspace instead, only the closing delimiter will be
deleted.

e.g. typing at the "|": >

                  What  |      Before      |      After
               ==============================================
                  <BS>  |  call expand(|)  |  call expand|
               ---------|------------------|-----------------
                 <S-BS> |  call expand(|)  |  call expand(|
<

------------------------------------------------------------------------------
   2.4 WRAPPING OF VISUAL SELECTION                *delimitMateVisualWrapping*

When visual mode is active this script allows for the selection to be enclosed
with delimiters. But, since brackets have special meaning in visual mode, a
leader (the value of 'mapleader' by default) should precede the delimiter.
This feature doesn't currently work on blockwise visual mode, any suggestions
will be welcome.

e.g. (selection represented between square brackets): >

                      Selected text    |       After \"
                 =============================================
                  An [absurd] example! | An "absurd" example!
<

------------------------------------------------------------------------------
   2.5 SMART QUOTES                                   *delimitMateSmartQuotes*

Only one quote will be inserted following a quote, a "\" or an alphanumeric
character. This should cover closing quotes, escaped quotes and apostrophes.
Except for apostrophes, this feature can be disabled setting the option
|'delimitMate_smart_quotes'| to 0.

e.g. typing at the "|": >

                     What |    Before    |     After
                  =======================================
                      "   |  "String|    |  "String"|
                      "   |  let i = "|  |  let i = "|"
                      '   |  I|          |  I'|
<
==============================================================================
 3. CUSTOMIZATION                                         *delimitMateOptions*

You can create your own mappings for some features using the global functions.
Read |DelimitMateFunctions| for more info.

------------------------------------------------------------------------------
   3.1 OPTIONS SUMMARY                              *delimitMateOptionSummary*

The behaviour of this script can be customized setting the following options
in your vimrc file. You can use local options to set the configuration for
specific file types, see |delimitMateOptionDetails| for examples.

|'loaded_delimitMate'|          Turns off the script.

|'delimitMate_autoclose'|       Tells delimitMate whether to automagically
                                insert the closing delimiter.

|'delimitMate_matchpairs'|      Tells delimitMate which characters are
                                matching pairs.

|'delimitMate_quotes'|          Tells delimitMate which quotes should be
                                used.

|'delimitMate_visual_leader'|   Sets the leader to be used in visual mode.

|'delimitMate_expand_cr'|       Turns on/off the expansion of <CR>.

|'delimitMate_expand_space'|    Turns on/off the expansion of <Space>.

|'delimitMate_excluded_ft'|     Turns off the script for the given file types.

|'delimitMate_apostrophes'|     Tells delimitMate how it should "fix"
                                balancing of single quotes when used as
                                apostrophes. NOTE: Not needed any more, kept
                                for compatibility with older versions.

|'delimitMate_smart_quotes'|    Turns on/off the "smart quotes" feature.

------------------------------------------------------------------------------
   3.2 OPTIONS DETAILS                              *delimitMateOptionDetails*

Add the shown lines to your vimrc file in order to set the below options.
Local options take precedence over global ones and can be used along with
autocmd to modify delimitMate's behavior for specific file types.

------------------------------------------------------------------------------
                                                        *'loaded_delimitMate'*
                                                      *'b:loaded_delimitMate'*
This option prevents delimitMate from loading.
e.g.: >
        let loaded_delimitMate = 1
        au FileType mail let b:loaded_delimitMate = 1
<
------------------------------------------------------------------------------
                                                     *'delimitMate_autoclose'*
                                                   *'b:delimitMate_autoclose'*
Values: 0 or 1.                                                              ~
Default: 1                                                                   ~

If this option is set to 0, delimitMate will not add a closing delimiter
automagically. See |delimitMateAutoClose| for details.
e.g.: >
        let delimitMate_autoclose = 0
        au FileType mail let b:delimitMate_autoclose = 0
<
------------------------------------------------------------------------------
                                                    *'delimitMate_matchpairs'*
                                                  *'b:delimitMate_matchpairs'*
Values: A string with |matchpairs| syntax.                                   ~
Default: &matchpairs                                                         ~

Use this option to tell delimitMate which characters should be considered
matching pairs. Read |delimitMateAutoClose| for details.
e.g: >
        let delimitMate = "(:),[:],{:},<:>"
        au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
<
------------------------------------------------------------------------------
                                                        *'delimitMate_quotes'*
                                                      *'b:delimitMate_quotes'*
Values: A string of characters separated by spaces.                          ~
Default: "\" ' `"                                                            ~

Use this option to tell delimitMate which characters should be considered as
quotes. Read |delimitMateAutoClose| for details.
e.g.: >
        let b:delimitMate_quotes = "\" ' ` *"
        au FileType html let b:delimitMate_quotes = "\" '"
<
------------------------------------------------------------------------------
                                                 *'delimitMate_visual_leader'*
                                               *'b:delimitMate_visual_leader'*
Values: Any character.                                                       ~
Default: q                                                                   ~

The value of this option will be used to wrap the selection in visual mode
when followed by a delimiter. Read |delimitMateVisualWrap| for details.
e.g: >
        let delimitMate_visual_leader = "f"
        au FileType html let b:delimitMate_visual_leader = "f"
<
------------------------------------------------------------------------------
                                                     *'delimitMate_expand_cr'*
                                                   *'b:delimitMate_expand_cr'*
Values: 1 or 0                                                               ~
Default: 0                                                                   ~

This option turns on/off the expansion of <CR>. Read |delimitMateExpansion|
for details.
e.g.: >
        let b:delimitMate_expand_cr = "\<CR>\<CR>\<Up>"
        au FileType mail let b:delimitMate_expand_cr = "\<CR>"
<
------------------------------------------------------------------------------
                                                  *'delimitMate_expand_space'*
                                                *'b:delimitMate_expand_space'*
Values: A key mapping.                                                       ~
Default: "\<Space>"                                                          ~

This option turns on/off the expansion of <Space>. Read |delimitMateExpansion|
for details.
e.g.: >
        let delimitMate_expand_space = "\<Space>\<Space>\<Left>"
        au FileType tcl let b:delimitMate_expand_space = "\<Space>"
<
------------------------------------------------------------------------------
                                                   *'delimitMate_excluded_ft'*
Values: A string of file type names separated by single commas.              ~
Default: Empty.                                                              ~

This options turns delimitMate off for the listed file types, use this option
only if you don't want any of the features it provides on those file types.
e.g.: >
        let delimitMate_excluded_ft = "mail,txt"
<
------------------------------------------------------------------------------
                                                   *'delimitMate_apostrophes'*
Values: Strings separated by ":".                                            ~
Default: No longer used.                                                     ~

NOTE: This feature is turned off by default, it's been kept for compatibility
with older version, read |delimitMateSmartQuotes| for details.
If auto-close is enabled, this option tells delimitMate how to try to fix the
balancing of single quotes when used as apostrophes. The values of this option
are strings of text where a single quote would be used as an apostrophe (e.g.:
the "n't" of wouldn't or can't) separated by ":". Set it to an empty string to
disable this feature.
e.g.: >
        let delimitMate_apostrophes = ""
        au FileType tcl let delimitMate_apostrophes = ""
<
==============================================================================
 4. COMMANDS                                             *delimitMateCommands*

------------------------------------------------------------------------------
:DelimitMateReload                                        *:DelimitMateReload*

Re-sets all the mappings used for this script, use it if any option has been
changed or if the filetype option hasn't been set yet.

------------------------------------------------------------------------------
:DelimitMateTest                                            *:DelimitMateTest*

This command tests every mapping set-up for this script, useful for testing
custom configurations.

The following output corresponds to the default values, it will be different
depending on your configuration. "Open & close:" represents the final result
when the closing delimiter has been inserted, either manually or
automatically, see |delimitMateExpansion|. "Delete:" typing backspace in an
empty pair, see |delimitMateBackspace|. "Exit:" typing a closing delimiter
inside a pair of delimiters, see |delimitMateAutoclose|. "Space:" the
expansion, if any, of space, see |delimitMateExpansion|. "Visual-L",
"Visual-R" and "Visual" shows visual wrapping, see
|delimitMateVisualWrapping|. "Car return:" the expansion of car return, see
|delimitMateExpansion|. The cursor's position at the end of every test is
represented by an "|": >

            * AUTOCLOSE:
            Open & close: (|)
            Delete: |
            Exit: ()|
            Space: ( |)
            Visual-L: (v)
            Visual-R: (v)
            Car return: (
            |)

            Open & close: {|}
            Delete: |
            Exit: {}|
            Space: { |}
            Visual-L: {v}
            Visual-R: {v}
            Car return: {
            |}

            Open & close: [|]
            Delete: |
            Exit: []|
            Space: [ |]
            Visual-L: [v]
            Visual-R: [v]
            Car return: [
            |]

            Open & close: "|"
            Delete: |
            Exit: ""|
            Space: " |"
            Visual: "v"
            Car return: "
            |"

            Open & close: '|'
            Delete: |
            Exit: ''|
            Space: ' |'
            Visual: 'v'
            Car return: '
            |'

            Open & close: `|`
            Delete: |
            Exit: ``|
            Space: ` |`
            Visual: `v`
            Car return: `
            |`
<

==============================================================================
 5. FUNCTIONS                                           *delimitMateFunctions*

------------------------------------------------------------------------------
delimitMate_WithinEmptyPair()                    *delimitMate_WithinEmptyPair*

Returns 1 if the cursor is inside an empty pair, 0 otherwise.

------------------------------------------------------------------------------
DelimitMate_ExpandReturn()                        *DelimitMate_ExpandReturn()*

Returns the expansion for <CR>.

e.g.: This mapping could be used to select an item on a pop-up menu or expand
<CR> inside an empty pair: >

        inoremap <expr> <CR> pumvisible() ? "\<c-y>" :
                 \ DelimitMate_WithinEmptyPair ?
                 \ DelimitMate_ExpandReturn() : "\<CR>"
<
------------------------------------------------------------------------------
DelimitMate_ExpandSpace()                          *DelimitMate_ExpandSpace()*

Returns the expansion for <Space>.
e.g.: >

	inoremap <expr> <Space> DelimitMate_WithinEmptyPair() ?
		\ DelimitMate_ExpandSpace() : "\<Space>"
<
------------------------------------------------------------------------------
DelimitMate_ShouldJump()                            *DelimitMate_ShouldJump()*

Returns 1 if there is a closing delimiter or a quote to the right of the
cursor, 0 otherwise.

------------------------------------------------------------------------------
DelimitMate_JumpAny()                                  *DelimitMate_JumpAny()*

This function returns a mapping that will make the cursor jump to the right.
e.g.: You can use this to create your own mapping to jump over any delimiter.
>
           inoremap <expr> <C-Tab> DelimitMate_ShouldJump() ?
                           \ DelimitMate_JumpAny() : "\<C-Tab>"
<

==============================================================================
 6. TODO LIST                                                *delimitMateTodo*

- Automatic set-up by file type.
- Make visual wrapping work on blockwise visual mode.
- Limit behaviour by region.

==============================================================================
 7. MAINTAINER                                         *delimitMateMaintainer*

Hi there! My name is Israel Chauca F. and I can be reached at:
    mailto:israelchauca@gmail.com

Feel free to send me any suggestions and/or comments about this plugin, I'll
be very pleased to read them.

==============================================================================
 8. CREDITS                                               *delimitMateCredits*

Some of the code that make this script is modified or just shamelessly copied
from the following sources:

   - Ian McCracken
     Post titled: Vim, Part II: Matching Pairs:
     http://concisionandconcinnity.blogspot.com/

   - Aristotle Pagaltzis
     From the comments on the previous blog post and from:
     http://gist.github.com/144619

   - Vim Scripts:
     http://www.vim.org/scripts

This script was inspired by the auto-completion of delimiters of TextMate.

==============================================================================
 9. HISTORY                                               *delimitMateHistory*

  Version      Date      Release notes                                       ~
|---------|------------|-----------------------------------------------------|
    2.0     2010-04-01   * New features:
                         - All features are redo/undo-wise safe.
                         - A single quote typed after an alphanumeric
                           character is considered an apostrophe and one
                           single quote is inserted.
                         - A quote typed after another quote inserts a single
                           quote and the cursor jumps to the middle.
                         - <S-Tab> jumps out of any empty pair.
                         - <CR> and <Space> expansions are fixed, but the
                           functions used for it are global and can be used in
                           custom mappings. The previous system is still
                           active if you have any of the expansion options
                           set.
                         - <S-Backspace> deletes the closing delimiter.

                         * Fixed bug:
                         - s:vars were being used to store buffer options.

|---------|------------|-----------------------------------------------------|
    1.6     2009-10-10   Now delimitMate tries to fix the balancing of single
                         quotes when used as apostrophes. You can read
                         |delimitMate_apostrophes| for details.
                         Fixed an error when |b:delimitMate_expand_space|
                         wasn't set but |delimitMate_expand_space| wasn't.

|---------|------------|-----------------------------------------------------|
    1.5     2009-10-05   Fix: delimitMate should work correctly for files
                         passed as arguments to Vim. Thanks to Ben Beuchler
                         for helping to nail this bug.

|---------|------------|-----------------------------------------------------|
    1.4     2009-09-27   Fix: delimitMate is now enabled on new buffers even
                         if they don't have set the file type option or were
                         opened directly from the terminal.

|---------|------------|-----------------------------------------------------|
    1.3     2009-09-24   Now local options can be used along with autocmd
                         for specific file type configurations.
                         Fixes:
                         - Unnamed register content is not lost on visual
                         mode.
                         - Use noremap where appropiate.
                         - Wrapping a single empty line works as expected.

|---------|------------|-----------------------------------------------------|
    1.2	    2009-09-07   Fixes:
                         - When inside nested empty pairs, deleting the
                         innermost left delimiter would delete all right
                         contiguous delimiters.
                         - When inside an empty pair, inserting a left
                         delimiter wouldn't insert the right one, instead
                         the cursor would jump to the right.
                         - New buffer inside the current window wouldn't
                         have the mappings set.

|---------|------------|-----------------------------------------------------|
    1.1     2009-08-25   Fixed an error that ocurred when mapleader wasn't
                         set and added support for GetLatestScripts
                         auto-detection.

|---------|------------|-----------------------------------------------------|
    1.0     2009-08-23   Initial upload.

|---------|------------|-----------------------------------------------------|


           ...           |"|         _     _       .      .         ___      ~
      o,*,(o o)         _|_|_      o' \,=./ `o   .  .:::.          /_\ `*    ~
     8(o o)(_)Ooo       (o o)         (o o)        :(o o):  .     (o o)      ~
---ooO-(_)---Ooo----ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo- ~

vim:tw=78:ts=8:ft=help:norl:formatoptions+=tcroqn:autoindent:
plugin/delimitMate.vim	[[[1
635
" ============================================================================
" File:        delimitMate.vim
" Version:     2.0
" Description: This plugin tries to emulate the auto-completion of delimiters
"              that TextMate provides.
" Maintainer:  Israel Chauca F. <israelchauca@gmail.com>
" Manual:      Read ":help delimitMate".
" Credits:     Some of the code is modified or just copied from the following:
"
"              - Ian McCracken
"           	 Post titled: Vim, Part II: Matching Pairs:
"           	 http://concisionandconcinnity.blogspot.com/
"
"              - Aristotle Pagaltzis
"           	 From the comments on the previous blog post and from:
"           	 http://gist.github.com/144619
"
"              - Vim Scripts:
"           	 http://www.vim.org/scripts/

" Initialization: {{{
if exists("g:loaded_delimitMate") "{{{
	" User doesn't want this plugin, let's get out!
	finish
endif
let g:loaded_delimitMate = 1

if exists("s:loaded_delimitMate") && !exists("g:delimitMate_testing")
	" Don't define the functions if they already exist: just do the work
	" (unless we are testing):
	call s:DelimitMateDo()
	finish
endif

if v:version < 700
	echoerr "delimitMate: this plugin requires vim >= 7!"
	finish
endif

let s:loaded_delimitMate = 1 " }}}
let delimitMate_version = '2.0'

function! s:Init() "{{{

	let b:loaded_delimitMate = 1

	" delimitMate_autoclose {{{
	if !exists("b:delimitMate_autoclose") && !exists("g:delimitMate_autoclose")
		let b:delimitMate_autoclose = 1
	elseif !exists("b:delimitMate_autoclose") && exists("g:delimitMate_autoclose")
		let b:delimitMate_autoclose = g:delimitMate_autoclose
	else
		" Nothing to do.
	endif " }}}

	" delimitMate_matchpairs {{{
	if !exists("b:delimitMate_matchpairs") && !exists("g:delimitMate_matchpairs")
		if s:ValidMatchpairs(&matchpairs) == 1
			let s:matchpairs_temp = &matchpairs
		else
			echoerr "delimitMate: There seems to be a problem with 'matchpairs', read ':help matchpairs' and fix it or notify the maintainer of this script if this is a bug."
			finish
		endif
	elseif exists("b:delimitMate_matchpairs")
		if s:ValidMatchpairs(b:delimitMate_matchpairs) || b:delimitMate_matchpairs == ""
			let s:matchpairs_temp = b:delimitMate_matchpairs
		else
			echoerr "delimitMate: Invalid format in 'b:delimitMate_matchpairs', falling back to matchpairs. Fix the error and use the command :DelimitMateReload to try again."
			if s:ValidMatchpairs(&matchpairs) == 1
				let s:matchpairs_temp = &matchpairs
			else
				echoerr "delimitMate: There seems to be a problem with 'matchpairs', read ':help matchpairs' and fix it or notify the maintainer of this script if this is a bug."
				let s:matchpairs_temp = ""
			endif
		endif
	else
		if s:ValidMatchpairs(g:delimitMate_matchpairs) || g:delimitMate_matchpairs == ""
			let s:matchpairs_temp = g:delimitMate_matchpairs
		else
			echoerr "delimitMate: Invalid format in 'g:delimitMate_matchpairs', falling back to matchpairs. Fix the error and use the command :DelimitMateReload to try again."
			if s:ValidMatchpairs(&matchpairs) == 1
				let s:matchpairs_temp = &matchpairs
			else
				echoerr "delimitMate: There seems to be a problem with 'matchpairs', read ':help matchpairs' and fix it or notify the maintainer of this script if this is a bug."
				let s:matchpairs_temp = ""
			endif
		endif

	endif " }}}

	" delimitMate_quotes {{{
	if exists("b:delimitMate_quotes")
		if b:delimitMate_quotes =~ '^\(\S\)\(\s\S\)*$' || b:delimitMate_quotes == ""
			let s:quotes = split(b:delimitMate_quotes)
		else
			let s:quotes = split("\" ' `")
			echoerr "delimitMate: There is a problem with the format of 'b:delimitMate_quotes', it should be a string of single characters separated by spaces. Falling back to default values."
		endif
	elseif exists("g:delimitMate_quotes")
		if g:delimitMate_quotes =~ '^\(\S\)\(\s\S\)*$' || g:delimitMate_quotes == ""
			let s:quotes = split(g:delimitMate_quotes)
		else
			let s:quotes = split("\" ' `")
			echoerr "delimitMate: There is a problem with the format of 'g:delimitMate_quotes', it should be a string of single characters separated by spaces. Falling back to default values."
		endif
	else
		let s:quotes = split("\" ' `")
	endif
	let b:delimitMate_quotes_list = s:quotes " }}}

	" delimitMate_visual_leader {{{
	if !exists("b:delimitMate_visual_leader") && !exists("g:delimitMate_visual_leader")
		let b:delimitMate_visual_leader = exists('b:maplocalleader') ? b:maplocalleader :
					\ exists('g:mapleader') ? g:mapleader : "\\"
	elseif !exists("b:delimitMate_visual_leader") && exists("g:delimitMate_visual_leader")
		let b:delimitMate_visual_leader = g:delimitMate_visual_leader
	else
		" Nothing to do.
	endif " }}}

	" delimitMate_expand_space {{{
	if !exists("b:delimitMate_expand_space") && !exists("g:delimitMate_expand_space")
		let b:delimitMate_expand_space = 0
	elseif !exists("b:delimitMate_expand_space") && !exists("g:delimitMate_expand_space")
		let b:delimitMate_expand_space = g:delimitMate_expand_space
	else
		" Nothing to do.
	endif " }}}

	" delimitMate_expand_cr {{{
	if !exists("b:delimitMate_expand_cr") && !exists("g:delimitMate_expand_cr")
		let b:delimitMate_expand_cr = 0
	elseif !exists("b:delimitMate_expand_cr") && exists("g:delimitMate_expand_cr")
		let b:delimitMate_expand_cr = g:delimitMate_expand_cr
	else
		" Nothing to do.
	endif " }}}

	" delimitMate_smart_quotes {{{
	if !exists("b:delimitMate_smart_quotes") && !exists("g:delimitMate_smart_quotes")
		let b:delimitMate_smart_quotes = 1
	elseif !exists("b:delimitMate_smart_quotes") && exists("g:delimitMate_smart_quotes")
		let b:delimitMate_smart_quotes = split(g:delimitMate_smart_quotes)
	else
		" Nothing to do.
	endif " }}}

	" delimitMate_apostrophes {{{
	if !exists("b:delimitMate_apostrophes") && !exists("g:delimitMate_apostrophes")
		"let s:apostrophes = split("n't:'s:'re:'m:'d:'ll:'ve:s'",':')
		let s:apostrophes = []
	elseif !exists("b:delimitMate_apostrophes") && exists("g:delimitMate_apostrophes")
		let s:apostrophes = split(g:delimitMate_apostrophes)
	else
		let s:apostrophes = split(b:delimitMate_apostrophes)
	endif
		let b:delimitMate_apostrophes_list = s:apostrophes " }}}

	" delimitMate_tab2exit {{{
	if !exists("b:delimitMate_tab2exit") && !exists("g:delimitMate_tab2exit")
		let b:delimitMate_tab2exit = 1
	elseif !exists("b:delimitMate_tab2exit") && exists("g:delimitMate_tab2exit")
		let b:delimitMate_tab2exit = g:delimitMate_tab2exit
	else
		" Nothing to do.
	endif " }}}

	let b:delimitMate_matchpairs_list = split(s:matchpairs_temp, ',')
	let b:delimitMate_left_delims = split(s:matchpairs_temp, ':.,\=')
	let b:delimitMate_right_delims = split(s:matchpairs_temp, ',\=.:')
	let s:VMapMsg = "delimitMate: delimitMate is disabled on blockwise visual mode."

	call s:UnMap()
	if b:delimitMate_autoclose
		call s:AutoClose()
	else
		call s:NoAutoClose()
	endif
	call s:VisualMaps()
	call s:ExtraMappings()

endfunction "}}} Init()
"}}}

" Utilities: {{{
function! s:ValidMatchpairs(str) "{{{
	if a:str !~ '^.:.\(,.:.\)*$'
		return 0
	endif
	for pair in split(a:str,',')
		if strpart(pair, 0, 1) == strpart(pair, 2, 1) || strlen(pair) != 3
			return 0
		endif
	endfor
	return 1
endfunction "}}}

function! DelimitMate_ShouldJump() "{{{
	let char = getline('.')[col('.') - 1]
	for pair in b:delimitMate_matchpairs_list
		if  char == split( pair, ':' )[1]
			" Same character on the rigth, jump over it.
			return 1
		endif
	endfor
	for quote in b:delimitMate_quotes_list
		if char == quote
			" Same character on the rigth, jump over it.
			return 1
		endif
	endfor
	return 0
endfunction "}}}

function! s:IsBlockVisual() " {{{
	if visualmode() == "<C-V>"
		return 1
	endif
	" Store unnamed register values for later use in s:RestoreRegister().
	let s:save_reg = getreg('"')
	let s:save_reg_mode = getregtype('"')

	if len(getline('.')) == 0
		" This for proper wrap of empty lines.
		let @" = "\n"
	endif
	return 0
endfunction " }}}

function! s:IsEmptyPair(str) "{{{
	for pair in b:delimitMate_matchpairs_list
		if a:str == join( split( pair, ':' ),'' )
			return 1
		endif
	endfor
	for quote in b:delimitMate_quotes_list
		if a:str == quote . quote
			return 1
		endif
	endfor
	return 0
endfunction "}}}

function! DelimitMate_WithinEmptyPair() "{{{
	let cur = strpart( getline('.'), col('.')-2, 2 )
	return s:IsEmptyPair( cur )
endfunction "}}}

function! s:WriteBefore(str) "{{{
	let len = len(a:str)
	let line = getline('.')
	let col = col('.')-2
	if col < 0
		call setline('.',line[(col+len+1):])
	else
		call setline('.',line[:(col)].line[(col+len+1):])
	endif
	return a:str
endfunction " }}}

function! s:WriteAfter(str) "{{{
	let len = len(a:str)
	let line = getline('.')
	let col = col('.')-2
	if (col) < 0
		call setline('.',a:str.line)
	else
		call setline('.',line[:(col)].a:str.line[(col+len):])
	endif
	return ''
endfunction " }}}

function! s:RestoreRegister() " {{{
	" Restore unnamed register values store in s:IsBlockVisual().
	call setreg('"', s:save_reg, s:save_reg_mode)
	echo ""
endfunction " }}}
" }}}

" Doers: {{{
function! s:JumpIn(char) " {{{
  let line = getline('.')
  let col = col('.')-2
  if (col) < 0
    call setline('.',a:char.line)
  else
    "echom string(col).':'.line[:(col)].'|'.line[(col+1):]
    call setline('.',line[:(col)].a:char.line[(col+1):])
  endif
  return ''
endfunction " }}}

function! s:JumpOut(char) "{{{
	let line = getline('.')
	let col = col('.')-2
	if line[col+1] == a:char
		call setline('.',line[:(col)].line[(col+2):])
	endif
	return a:char
endfunction " }}}

function! DelimitMate_JumpAny() " {{{
	let nchar = getline('.')[col('.')-1]
	return nchar . "\<Del>"
endfunction " DelimitMate_JumpAny() }}}

function! s:SkipDelim(char) "{{{
	let cur = strpart( getline('.'), col('.')-2, 3 )
	if cur[0] == "\\"
		" Escaped character
		return a:char
	elseif cur[1] == a:char
		" Exit pair
		return s:WriteBefore(a:char)
	"elseif cur[1] == ' ' && cur[2] == a:char
		"" I'm leaving this in case someone likes it. Jump an space and delimiter.
		"return "\<Right>\<Right>"
	elseif s:IsEmptyPair( cur[0] . a:char )
		" Add closing delimiter and jump back to the middle.
		return s:WriteAfter(a:char)
	else
		" Nothing special here, return the same character.
		return a:char
	endif
endfunction "}}}

function! s:QuoteDelim(char) "{{{
	let line = getline('.')
	let col = col('.') - 2
	if line[col] == "\\"
		" Seems like a escaped character, insert one quotation mark.
		return a:char
	elseif line[col + 1] == a:char
		" Get out of the string.
		return s:WriteBefore(a:char)
	elseif (line[col] =~ '[a-zA-Z0-9]' && a:char == "'") ||
				\(line[col] =~ '[a-zA-Z0-9]' && b:delimitMate_smart_quotes)
		" Seems like an apostrophe or a closing, insert a single quote.
		return a:char
	elseif (line[col] == a:char && line[col + 1 ] != a:char) && b:delimitMate_smart_quotes
		" Seems like we have an unbalanced quote, insert one quotation mark and jump to the middle.
		return s:WriteAfter(a:char)
	else
		" Insert a pair and jump to the middle.
		call s:WriteAfter(a:char)
		return a:char
	endif
endfunction "}}}

function! s:MapMsg(msg) "{{{
	redraw
	echomsg a:msg
	return ""
endfunction "}}}
"}}}

" Mappings: {{{
function! s:NoAutoClose() "{{{
	" inoremap <buffer> ) <C-R>=<SID>SkipDelim('\)')<CR>
	for delim in b:delimitMate_right_delims + b:delimitMate_quotes_list
		exec 'inoremap <buffer> ' . delim . ' <C-R>=<SID>SkipDelim("' . escape(delim,'"') . '")<CR>'
	endfor
endfunction "}}}

function! s:AutoClose() "{{{
	" Add matching pair and jump to the midle:
	" inoremap <buffer> ( ()<Left>
	let i = 0
	while i < len(b:delimitMate_matchpairs_list)
		let ld = b:delimitMate_left_delims[i]
		let rd = b:delimitMate_right_delims[i]
		exec 'inoremap <buffer> ' . ld . ' ' . ld . '<C-R>=<SID>JumpIn("' . rd . '")<CR>'
		let i += 1
	endwhile

	" Add matching quote and jump to the midle, or exit if inside a pair of matching quotes:
	" inoremap <buffer> " <C-R>=<SID>QuoteDelim("\"")<CR>
	for delim in b:delimitMate_quotes_list
		exec 'inoremap <buffer> ' . delim . ' <C-R>=<SID>QuoteDelim("\' . delim . '")<CR>'
	endfor

	" Exit from inside the matching pair:
	for delim in b:delimitMate_right_delims
		exec 'inoremap <buffer> ' . delim . ' <C-R>=<SID>JumpOut("\' . delim . '")<CR>'
	endfor

	" Try to fix the use of apostrophes (de-activated by default):
	" inoremap <buffer> n't n't
	for map in b:delimitMate_apostrophes_list
		exec "inoremap <buffer> " . map . " " . map
	endfor

endfunction "}}}

function! s:VisualMaps() " {{{
	let vleader = b:delimitMate_visual_leader
	" Wrap the selection with matching pairs, but do nothing if blockwise visual mode is active:
	let i = 0
	while i < len(b:delimitMate_matchpairs_list)
		" Map left delimiter:
		let ld = b:delimitMate_left_delims[i]
		let rd = b:delimitMate_right_delims[i]
		exec 'vnoremap <buffer> <expr> ' . vleader . ld . ' <SID>IsBlockVisual() ? <SID>MapMsg("' . s:VMapMsg . '") : "s' . ld . '\<C-R>\"' . rd . '\<Esc>:call <SID>RestoreRegister()<CR>"'

		" Map right delimiter:
		exec 'vnoremap <buffer> <expr> ' . vleader . rd . ' <SID>IsBlockVisual() ? <SID>MapMsg("' . s:VMapMsg . '") : "s' . ld . '\<C-R>\"' . rd . '\<Esc>:call <SID>RestoreRegister()<CR>"'
		let i += 1
	endwhile

	" Wrap the selection with matching quotes, but do nothing if blockwise visual mode is active:
	for quote in b:delimitMate_quotes_list
		" vnoremap <buffer> <expr> \' <SID>IsBlockVisual() ? <SID>MapMsg("Message") : "s'\<C-R>\"'\<Esc>:call <SID>RestoreRegister()<CR>"
		exec 'vnoremap <buffer> <expr> ' . vleader . quote . ' <SID>IsBlockVisual() ? <SID>MapMsg("' . s:VMapMsg . '") : "s' . escape(quote,'"') .'\<C-R>\"' . escape(quote,'"') . '\<Esc>:call <SID>RestoreRegister()<CR>"'
	endfor
endfunction "}}}

function! DelimitMate_ExpandReturn() "{{{
	" Expand:
	return "\<Esc>a\<CR>x\<CR>\<Esc>k$\"_xa"
endfunction "}}}

function! DelimitMate_ExpandSpace() "{{{
	" Expand:
	return s:WriteAfter(' ') . "\<Space>"
endfunction "}}}

function! s:ExtraMappings() "{{{
	" If pair is empty, delete both delimiters:
	inoremap <buffer> <expr> <BS> DelimitMate_WithinEmptyPair() ? "\<Right>\<BS>\<BS>" : "\<BS>"

	" If pair is empty, delete closing delimiter:
	inoremap <buffer> <expr> <S-BS> DelimitMate_WithinEmptyPair() ? "\<Del>" : "\<S-BS>"

	" Expand return if inside an empty pair:
	if b:delimitMate_expand_cr != 0
		inoremap <buffer> <expr> <CR> DelimitMate_WithinEmptyPair() ?
					\ DelimitMate_ExpandReturn() : "\<CR>"
	endif

	" Expand space if inside an empty pair:
	if b:delimitMate_expand_space != 0
		inoremap <buffer> <expr> <Space> DelimitMate_WithinEmptyPair() ?
					\ DelimitMate_ExpandSpace() : "\<Space>"
	endif

	" Jump out ot any empty pair:
	if b:delimitMate_tab2exit
		inoremap <buffer> <expr> <S-Tab> DelimitMate_ShouldJump() ? DelimitMate_JumpAny() : "\<S-Tab>"
	endif
endfunction "}}}
"}}}

" Tools: {{{
function! s:TestMappings() "{{{
	if b:delimitMate_autoclose
		 exec "normal i* AUTOCLOSE:\<CR>"
		for i in range(len(b:delimitMate_left_delims))
			exec "normal GGAOpen & close: " . b:delimitMate_left_delims[i]. "|"
			exec "normal A\<CR>Delete: " . b:delimitMate_left_delims[i] . "\<BS>|"
			exec "normal A\<CR>Exit: " . b:delimitMate_left_delims[i] . b:delimitMate_right_delims[i] . "|"
			exec "normal A\<CR>Space: " . b:delimitMate_left_delims[i] . " |"
			exec "normal GGA\<CR>Visual-L: v\<Esc>v" . b:delimitMate_visual_leader . b:delimitMate_left_delims[i]
			exec "normal A\<CR>Visual-R: v\<Esc>v" . b:delimitMate_visual_leader . b:delimitMate_right_delims[i]
			exec "normal A\<CR>Car return: " . b:delimitMate_left_delims[i] . "\<CR>|\<Esc>GGA\<CR>\<CR>"
		endfor
		for i in range(len(b:delimitMate_quotes_list))
			exec "normal GGAOpen & close: " . b:delimitMate_quotes_list[i]	. "|"
			exec "normal A\<CR>Delete: "
			exec "normal A". b:delimitMate_quotes_list[i]
			exec "normal a\<BS>|"
			exec "normal A\<CR>Exit: " . b:delimitMate_quotes_list[i] . b:delimitMate_quotes_list[i] . "|"
			exec "normal A\<CR>Space: " . b:delimitMate_quotes_list[i] . " |"
			exec "normal GGA\<CR>Visual: v\<Esc>v" . b:delimitMate_visual_leader . b:delimitMate_quotes_list[i]
			exec "normal A\<CR>Car return: " . b:delimitMate_quotes_list[i] . "\<CR>|\<Esc>GGA\<CR>\<CR>"
		endfor
	else
		exec "normal i* NO AUTOCLOSE:\<CR>"
		for i in range(len(b:delimitMate_left_delims))
			exec "normal GGAOpen & close: " . b:delimitMate_left_delims[i]	. b:delimitMate_right_delims[i] . "|"
			exec "normal A\<CR>Delete: " . b:delimitMate_left_delims[i] . b:delimitMate_right_delims[i] . "\<BS>|"
			exec "normal A\<CR>Exit: " . b:delimitMate_left_delims[i] . b:delimitMate_right_delims[i] . b:delimitMate_right_delims[i] . "|"
			exec "normal A\<CR>Space: " . b:delimitMate_left_delims[i] . b:delimitMate_right_delims[i] . " |"
			exec "normal GGA\<CR>Visual-L: v\<Esc>v" . b:delimitMate_visual_leader . b:delimitMate_left_delims[i]
			exec "normal A\<CR>Visual-R: v\<Esc>v" . b:delimitMate_visual_leader . b:delimitMate_right_delims[i]
			exec "normal A\<CR>Car return: " . b:delimitMate_left_delims[i] . b:delimitMate_right_delims[i] . "\<CR>|\<Esc>GGA\<CR>\<CR>"
		endfor
		for i in range(len(b:delimitMate_quotes_list))
			exec "normal GGAOpen & close: " . b:delimitMate_quotes_list[i]	. b:delimitMate_quotes_list[i] . "|"
			exec "normal A\<CR>Delete: " . b:delimitMate_quotes_list[i] . b:delimitMate_quotes_list[i] . "\<BS>|"
			exec "normal A\<CR>Exit: " . b:delimitMate_quotes_list[i] . b:delimitMate_quotes_list[i] . b:delimitMate_quotes_list[i] . "|"
			exec "normal A\<CR>Space: " . b:delimitMate_quotes_list[i] . b:delimitMate_quotes_list[i] . " |"
			exec "normal GGA\<CR>Visual: v\<Esc>v" . b:delimitMate_visual_leader . b:delimitMate_quotes_list[i]
			exec "normal A\<CR>Car return: " . b:delimitMate_quotes_list[i] . b:delimitMate_quotes_list[i] . "\<CR>|\<Esc>GGA\<CR>\<CR>"
		endfor
	endif
	exec "normal \<Esc>i"
endfunction "}}}

function! s:SwitchAutoclose() "{{{
	if !exists("g:delimitMate_autoclose")
		let g:delimitMate_autoclose = 1
	elseif g:delimitMate_autoclose == 1
		let g:delimitMate_autoclose = 0
	else
		let g:delimitMate_autoclose = 1
	endif
	DelimitMateReload
endfunction "}}}

function! s:UnMap() " {{{
	" No Autoclose Mappings:
	for char in b:delimitMate_right_delims + b:delimitMate_quotes_list
		if maparg(char,"i") =~? 'SkipDelim'
			exec 'silent! iunmap <buffer> ' . char
			"echomsg 'iunmap <buffer> ' . char
		endif
	endfor

	" Autoclose Mappings:
	let i = 0
	let l = len(b:delimitMate_matchpairs_list)
	while i < l
		if maparg(b:delimitMate_left_delims[i],"i") =~? 'JumpIn'
			exec 'silent! iunmap <buffer> ' . b:delimitMate_left_delims[i]
			"echomsg 'iunmap <buffer> ' . b:delimitMate_left_delims[i]
		endif
		let i += 1
	endwhile
	for char in b:delimitMate_quotes_list
		if maparg(char, "i") =~? 'QuoteDelim'
			exec 'silent! iunmap <buffer> ' . char
			"echomsg 'iunmap <buffer> ' . char
		endif
	endfor
	for char in b:delimitMate_right_delims
		if maparg(char, "i") =~? 'JumpOut'
			exec 'silent! iunmap <buffer> ' . char
			"echomsg 'iunmap <buffer> ' . char
		endif
	endfor
	for map in b:delimitMate_apostrophes_list
		exec "silent! iunmap <buffer> " . map
	endfor

	" Visual Mappings:
	for char in b:delimitMate_right_delims + b:delimitMate_left_delims + b:delimitMate_quotes_list
		if maparg(b:delimitMate_visual_leader . char,"v") =~? 'IsBlock'
			exec 'silent! vunmap <buffer> ' . b:delimitMate_visual_leader . char
			"echomsg 'vunmap <buffer> ' . b:delimitMate_visual_leader . char
		endif
	endfor

	" Expansion Mappings:
	if maparg('<BS>', "i") =~? 'WithinEmptyPair'
		silent! iunmap <buffer> <BS>
		"echomsg "silent! iunmap <buffer> <BS>"
	endif
	if maparg('<S-BS>', "i") =~? 'WithinEmptyPair'
		silent! iunmap <buffer> <BS>
		"echomsg "silent! iunmap <buffer> <BS>"
	endif
	if maparg('<CR>',"i") =~? 'DelimitMate_ExpandReturn'
		silent! iunmap <buffer> <CR>
		"echomsg "silent! iunmap <buffer> <CR>"
	endif
	if maparg('<Space>',"i") =~? 'DelimitMate_ExpandSpace'
		silent! iunmap <buffer> <Space>
		"echomsg "silent! iunmap <buffer> <Space>"
	endif
	if maparg('<S-Tab>', "i") =~? 'ShouldJump'
		silent! iunmap <buffer> <S-Tab>
		"echomsg "silent! iunmap <buffer> <S-Tab>"
	endif
endfunction " }}} s:ExtraMappings()

function! s:TestMappingsDo() "{{{
	"DelimitMateReload
	if !exists("g:delimitMate_testing")
		"call s:DelimitMateDo()
		call s:TestMappings()
	else
		call s:SwitchAutoclose()
		call s:TestMappings()
		exec "normal i\<CR>"
		call s:SwitchAutoclose()
		call s:TestMappings()
	endif
endfunction "}}}

function! s:DelimitMateDo() "{{{
	if exists("g:delimitMate_excluded_ft")
		" Check if this file type is excluded:
		for ft in split(g:delimitMate_excluded_ft,',')
			if ft ==? &filetype
				if !exists("b:delimitMate_quotes_list")
					return 1
				endif
				"echomsg "excluded"
				call s:UnMap()
				return 1
			endif
		endfor
	endif
	try
		"echomsg "included"
		let save_cpo = &cpo
		set cpo&vim
		call s:Init()
	finally
		let &cpo = save_cpo
	endtry
endfunction "}}}
"}}}

" Commands: {{{
call s:DelimitMateDo()

" Let me refresh without re-loading the buffer:
command! DelimitMateReload call s:DelimitMateDo()

" Quick test:
command! DelimitMateTest call s:TestMappingsDo()

" Run on file type events.
"autocmd VimEnter * autocmd FileType * call <SID>DelimitMateDo()
autocmd FileType * call <SID>DelimitMateDo()

" Run on new buffers.
autocmd BufNewFile,BufRead,BufEnter * if !exists("b:loaded_delimitMate") | call <SID>DelimitMateDo() | endif

"function! s:GetSynRegion () | echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') | endfunction
"}}}

" GetLatestVimScripts: 2754 1 :AutoInstall: delimitMate.vim
" vim:foldmethod=marker:foldcolumn=4
