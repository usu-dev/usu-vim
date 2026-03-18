" WARNING: this was vibecoded
" Vim syntax file
" Language: usu
" Maintainer: daylinmmorgan
" Latest Revision: 2026

if exists("b:current_syntax")
  finish
endif

" Case sensitive matching
syn case match

" ============================================================================
" PRIORITY NOTE
" ============================================================================
" Vim resolves conflicts between syn match items at the same position by
" using the LAST defined item. Items earlier in the file have LOWER priority.
" Regions (syn region) have higher priority than matches (syn match).
"
" Definition order here is intentional:
"   1. Comments    - regions, highest structural priority
"   2. Quoted keys - regions, start at '.' so beat strings at same position
"   3. Strings     - regions
"   4. Delimiters  - matches: {, }, [, ]
"   5. Numbers     - matches
"   6. Unquoted keys - matches, defined LAST so they beat delimiters when
"                      both want to claim the same '{' or whitespace position

" ============================================================================
" 1. COMMENTS
" ============================================================================
" Block comments: #( ... )#
" Line comments:  # ... (but NOT #( which starts a block comment)
"   The negative lookahead [^(] ensures '#(' is left for usuBlockComment.
"   The \|$ alternative handles a bare '#' at end of line.

syn region usuBlockComment start="#(" end=")#" contains=@Spell
syn match  usuLineComment  "#\%([^(]\|$\).*" contains=@Spell

" ============================================================================
" 2. QUOTED KEYS
" ============================================================================
" Quoted keys begin with a literal dot then a quote: ."key" .'key' .`key`
" Defined before usuString so that at the '.' position these regions are
" found first (earlier position in text beats later position).
" '|' is used as the pattern delimiter to avoid escaping the quote chars.

syn region usuKeyDouble   start=|\."| skip=|\\"| end=|"|
syn region usuKeySingle   start=|\.'| skip=|\\'| end=|'|
syn region usuKeyBacktick start=|\.`|            end=|`|

" ============================================================================
" 3. STRINGS (VALUES)
" ============================================================================

syn region usuString start=+"+ skip=+\\"+ end=+"+
syn region usuString start=+'+ skip=+\\'+ end=+'+
syn region usuString start=+`+            end=+`+

" ============================================================================
" 4. DELIMITERS AND NUMBERS
" ============================================================================

syn match usuDelimiter "[{}[\]]"
syn match usuNumber    "\v<\d+>"

" ============================================================================
" 5. UNQUOTED KEYS
" ============================================================================
" Unquoted keys: a dot followed by alphanumeric/underscore/hyphen/dot chars.
" e.g. .meta  .title  .meta.description
"
" Defined AFTER usuDelimiter so that when an unquoted key immediately follows
" a '{' (e.g. '{.key val}'), usuKey has higher priority and wins.
"
" Zero-width lookbehind (\@<=) is used instead of consuming the preceding
" character. This means the match starts at '.' rather than at the bracket
" or space, so usuDelimiter can still highlight '{' independently.
"
" Two patterns cover the valid positions a key can appear:
"   - At the start of a line
"   - After a space, tab, opening brace '{', or a closing quote (" ' `)
"     The closing quote case handles chained quoted+unquoted keys:
"     e.g. ."quoted key".unquoted
" Keys following '[' are intentionally excluded as that is invalid syntax.

syn match usuKey "^\.[a-zA-Z0-9_\-\.\\/]\+"
syn match usuKey "[ \t{\"'`]\@<=\.[a-zA-Z0-9_\-\.\\/]\+"

" ============================================================================
" 6. HIGHLIGHT LINKS
" ============================================================================

hi def link usuBlockComment Comment
hi def link usuLineComment  Comment
hi def link usuKeyDouble    Keyword
hi def link usuKeySingle    Keyword
hi def link usuKeyBacktick  Keyword
hi def link usuKey          Keyword
hi def link usuString       String
hi def link usuDelimiter    Delimiter
hi def link usuNumber       Number

let b:current_syntax = "usu"
