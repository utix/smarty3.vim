"
"
"
if exists("b:current_syntax")
    finish
endif

if !exists("main_syntax")
  let main_syntax = 'smarty'
endif

if exists('smarty_left_delimiter')
  let b:smarty_left_delimiter = smarty_left_delimiter
else
  let b:smarty_left_delimiter = '{'
endif

if exists('smarty_right_delimiter')
  let b:smarty_right_delimiter = smarty_right_delimiter
else
  let b:smarty_right_delimiter = '}'
endif

syn case ignore

runtime! syntax/html.vim


syn match smartyVarSelector contained "\$"
syn match smartyIdent contained "$\h\w*" contains=smartyVarSelector
syn match smartyIdent contained "\.\h\w*"
syn match smartyIdent contained "->\h\w*"
syn match smartyIdent contained "\[\w*\]"

" modifires
syn keyword smartyModifier capitalize cat count_characters count_paragraphs
syn keyword smartyModifier count_sentences count_words date_format default
syn keyword smartyModifier escape indent lower nl2br regex_replace replace
syn keyword smartyModifier spacify string_format strip strip_tags truncate
syn keyword smartyModifier upper wordwrap

" built-in functions
syn keyword smartyTagName append assign block call capture config_load debug
syn keyword smartyTagName extends for foreach foreachelse function
syn keyword smartyTagName if elseif else include include_php insert
syn keyword smartyTagName ldelim rdelim literal nocache php section sectionelse
syn keyword smartyTagName strip while

" custom functions
syn keyword smartyTagName counter cycle eval fetch html_checkboxes
syn keyword smartyTagName html_image html_options html_radios html_select_date
syn keyword smartyTagName html_select_time html_table mailto math textformat


" operators
syn keyword smartyInFunc eq ne neq gt lt gte ge lte le not mod is div by even odd

syn keyword smartyProperty contained "file="
syn keyword smartyProperty contained "loop="
syn keyword smartyProperty contained "name="
syn keyword smartyProperty contained "include="
syn keyword smartyProperty contained "skip="
syn keyword smartyProperty contained "section="

syn keyword smartyConstant "\$smarty"

syn region smartyString contained start=+'+ skip=+\\\\\|\\'+ end=+'+
syn region smartyString contained start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=smartyBacktick
syn region smartyBacktick contained start=+`+ end=+`+ contains=smartyIdent

syn cluster smartyGroup contains=smartyModifier,smartyTagName,smartyInFunc,smartyProperty,smartyConstant,smartyString,smartyBacktick,smartyBlock,smartyIdent

" smarty region
execute "syn region smartyZone matchgroup=Delimiter"
      \ . " start=+" . b:smarty_left_delimiter . "/\\?+"
      \ . " end=+" . b:smarty_right_delimiter . "+"
      \ . " contains=@smartyGroup"
      \ . " containedin=ALLBUT,@smartyZone,smartyComment"

" smarty comment
execute "syn region smartyComment start=+" . b:smarty_left_delimiter
      \ . "\\*+ end=+\\*" . b:smarty_right_delimiter . "+"
      \ . " containedin=ALL"



hi link smartyString String
hi link smartyBacktick Function
hi link smartyTagName Type
hi link smartyIdent Identifier
hi link smartyVarSelector Statement
hi link smartyComment Comment

if main_syntax == 'smarty'
  unlet main_syntax
endif

" vim: ts=8 sts=2 sw=2 expandtab
