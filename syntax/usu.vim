" WARNING: this was vibecoded
" Vim syntax file
" Language: usu
" Maintainer: Local
" Latest Revision: 2026

if exists("b:current_syntax")
  finish
endif

" Case sensitive matching
syn case match

" ============================================================================
" 1. COMMENTS
" ============================================================================
" Priority: Block comments must match first.
" The line comment uses a negative check to ensure it doesn't "eat" the start
" of a block comment (# followed by anything EXCEPT opening paren).

syn region usuBlockComment start="#(" end=")#" contains=@Spell
syn match  usuLineComment  "#\%([^(]\|$\).*" contains=@Spell

" ============================================================================
" 2. KEYS (QUOTED & UNQUOTED)
" ============================================================================
" We define Keys *before* Strings. Since keys start with a dot (.), the match
" starts one character earlier than a string would. Vim prioritizes the
" earliest match, so `."key"` is correctly identified as a Key, not a String.

" A. Quoted Keys (e.g. ."key" .'key' .`key`)
" We use | as delimiters to cleanly handle quotes and backticks in the pattern.
syn region usuKeyDouble start=|\."| skip=|\\"| end=|"|
syn region usuKeySingle start=|\.'| skip=|\\'| end=|'|
syn region usuKeyBacktick start=|\.`| end=|`|

" B. Unquoted Keys (e.g. .meta .title .meta.description)
" Logic:
" 1. \v : Very magic regex mode
" 2. (^|[ \t\{\[]) : Look-behind. Must be preceded by Start-of-line, Space, Tab, { or [
" 3. \zs : Start highlighting HERE (don't highlight the preceding space/bracket)
" 4. \. : Literal dot
" 5. [a-zA-Z0-9_\-\.]+ : The key name (alphanumeric, _, -,\,/ and dots)
syn match usuKey "\v(^|[ \t\{\[])\zs\.[a-zA-Z0-9_\-\.\\/]+"

" ============================================================================
" 3. STRINGS (VALUES)
" ============================================================================
" Standard string highlighting for values.

syn region usuString start=+"+ skip=+\\"+ end=+"+
syn region usuString start=+'+ skip=+\\'+ end=+'+
syn region usuString start=+`+ end=+`+

" ============================================================================
" 4. MISC (NUMBERS & DELIMITERS)
" ============================================================================

syn match usuDelimiter "[{}[\]]"
syn match usuNumber "\v<\d+>"

" ============================================================================
" 5. HIGHLIGHT LINKS
" ============================================================================

hi def link usuBlockComment Comment
hi def link usuLineComment  Comment

" Link all key variations to the main Keyword color
hi def link usuKeyDouble    Keyword
hi def link usuKeySingle    Keyword
hi def link usuKeyBacktick  Keyword
hi def link usuKey          Keyword

hi def link usuString       String
hi def link usuDelimiter    Delimiter
hi def link usuNumber       Number

let b:current_syntax = "usu"


