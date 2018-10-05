" Colors.
syntax enable
set background=dark
colorscheme slate
hi Statement ctermfg=LightCyan
hi Comment ctermfg=Yellow cterm=bold
" Font.
set guifont=DejaVu\ Sans\ Mono\ 10
" Show trailing whitespace.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

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
" set nu

" Window dressing.
" If a file is changed while vim has it open, and vim doesn't have unsaved changes, automatically reload file.
set autoread

" Hotkeys.
" Custom mapleader.
:let mapleader = ","
" Map a latex compile button.
map <leader>ll :w !latexmk -silent -pdf % <enter>
map <leader>vs :w !/opt/vertica/bin/vsql -h vertica.csnzoo.com Wayfair ryi -f % <enter>

" Remap gj, gj (display line movement) to j, k.
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
" Also remap 0 and $ so they go to the end of the display line, rather than
" the paragraph.
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$

" Allows `//` to visually search for selected text.
vnoremap // y/<C-R>"<CR>

" Spell-check.
au BufNewFile,BufRead *.tex set spell

" Set paste hotkey.
set pastetoggle=<F3>

" Let gf detect python files.
filetype plugin on

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
