" Colors.
set background=dark
" Font.
set guifont=DejaVu\ Sans\ Mono\ 10

" Tab hehavior.
" Use spaces rather than tabs.
set expandtab
" Makes backspace delete shiftwidth spaces, rather than one.
set smarttab
" Tabs are 4 spaces.
set tabstop=4
" Indentation uses shiftwidth. Pressing tab uses tabstop.
set shiftwidth=4
set autoindent

" Word-wrapping.
" Wraps visually, without newlines.
set wrap
" Keeps words together at linebreak.
set linebreak

" Line numbers.
"set nu

" Window dressing.
" If a file is changed while vim has it open, and vim doesn't have unsaved changes, automatically reload file.
set autoread

" Hotkeys.
" Custom mapleader.
:let mapleader = ","
" Map a latex compile button.
map <leader>ll :w !latexmk -silent -pdf % <enter>

" Remap gj, gj (display line movement) to j, k.
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
" Also remap 0 and $ so they go to the end of the display line, rather than
" the paragraph.
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
" Prevent k and j from behaving strangely in operator mode.
omap <silent> j gj
omap <silent> k gk

" Spell-check.
au BufNewFile,BufRead *.tex set spell
