" vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Custom plugins.
Plug 'vimwiki/vimwiki'
" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

" vimwiki customizations.
" Required.
set nocompatible
filetype plugin on
syntax on
" Currently, this is only set up for one vimwiki directory.
" For work, add `wiki_2` following the instructions here:
" https://opensource.com/article/18/6/vimwiki-gitlab-notes
let wiki_1 = {}
let wiki_1.path = '~/vimwiki-personal/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" vim-lsp registration.
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" Colors.
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
" Two spaces for HTML files.
autocmd FileType html :setlocal sw=2 ts=2 sts=2

" Word-wrapping.
" Wraps visually, without newlines.
set wrap
" Keeps words together at linebreak.
set linebreak

" Line numbers hybrid.
set nu rnu

" Window dressing.
" If a file is changed while vim has it open, and vim doesn't have unsaved changes, automatically reload file.
set autoread

" Hotkeys.
" Custom mapleader.
let mapleader = ","
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
set pastetoggle=<F2>

" Let gf detect python files.
filetype plugin on

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    syn region math_inline start="\\\\(" end="\\\\)"
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
    hi link math_inline Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()
