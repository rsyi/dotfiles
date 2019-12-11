" vim-plug
"get_config Install vim-plug if it doesn't exist.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Custom plugins.
Plug 'vimwiki/vimwiki'
Plug 'metakirby5/codi.vim'
" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

" vimwiki customizations.
" Required.
set nocompatible
filetype plugin on
syntax on
" Currently, this is only set up for one vimwiki directory.
" For work, add `wiki_2` following the instructions here:
" https://opensource.com/article/18/6/vimwiki-gitlab-notes
let g:vimwiki_list = [
    \ {'path': '~/vimwiki-dataframe', 'syntax': 'markdown', 'ext': '.md'},
    \ {'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}
    \ ]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_url_maxsave=0
let g:vimwiki_global_ext=0

" vim-lsp registration.
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
" Asyncomplete source registration.
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" Vimlsp hotkeys.
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>

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
" Prevent weird 8 space tabs in python files.
autocmd FileType python setlocal tabstop=4
" Two spaces for HTML files.
au FileType html :setlocal sw=2 ts=2 sts=2
" Hive syntax: 'hive' needs to exist in `~/.vim/syntax` for this to work (google "hive vim").
au BufRead,BufNewFile,BufEnter *.hql,*.sql set filetype=sql ts=2 sw=2
au BufRead,BufNewFile,BufEnter *.yaml setlocal ts=2 sw=2

" Word-wrapping.
" Wraps visually, without newlines.
set wrap
" Keeps words together at linebreak.
set linebreak

" Line numbers hybrid.
set nu rnu
" Command to toggle on/off.
noremap <F3> :set nu! rnu!<CR>

" Window dressing.
" If a file is changed while vim has it open, and vim doesn't have unsaved changes, automatically reload file.
set autoread

" Hotkeys.
" Custom mapleader.
let mapleader = ","
" Map a latex compile button.
map <leader>ll :w !latexmk -silent -pdf % <enter>

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

" Call everytime we open a Markdown file.
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

" Datetime hotkey for vimwiki.
nnoremap <F5> "=strftime("%b %d, %Y")<CR>P
inoremap <F5> <C-R>=strftime("%b %d, %Y")<CR>

" Automatically set working directory to current file.
set autochdir

" Following vimwiki docs, use vfile in links to allow for non-.md files to be opened.
function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'e' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction

nnoremap <C-j> :VimwikiDiaryNextDay<CR>
nnoremap <C-k> :VimwikiDiaryPrevDay<CR>
