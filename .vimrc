"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Robert Yi (github.com/rsyi)
"
" This is my personal vimrc setup.
"
" Index:
"   - Install plugins
"   - Plugin: vim-lsp
"   - General
"   - Plugin: vimwiki
"   - Custom: latex math syntax highlighting
"   - Plugin: Goyo
"   - Hotkeys
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins
"
"    vim-plug is automatically if it doesn't exist. All plugins are then
"    installed using vim-plug.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug if it doesn't exist.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" Better defaults: backspace through lines, search dynamically.
Plug 'tpope/vim-sensible'

" Improved file tree.
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Wiki for vim (for note-taking).
Plug 'vimwiki/vimwiki'

" Dynamic hacker coding (a la jupyter).
Plug 'metakirby5/codi.vim'

" React js syntax highlighting.
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Easier visual mode.
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'

" vim-test.
Plug 'janko/vim-test'

" vim-blame.
Plug 'APZelos/blamer.nvim'

" Fugitive.
Plug 'tpope/vim-fugitive'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" fuzzy finder.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" YouCompleteMe.
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype plugin on  " Necessary for auto file detection.
syntax on  " Enable syntax highlighting.
set noswapfile  " Disable swap files.

" Allow for scrolling.
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Colors.
set background=dark
colorscheme slate
hi Statement ctermfg=LightCyan
hi Comment ctermfg=darkgrey cterm=bold
hi LineNr ctermfg=darkblue
hi Search ctermbg=lightcyan ctermfg=black
hi VertSplit ctermfg=black ctermbg=black
hi EndOfBuffer ctermfg=black
hi IncSearch ctermfg=black
hi Visual ctermfg=LightYellow ctermbg=black
hi Pmenu ctermbg=darkgray ctermfg=white
hi PmenuSel ctermbg=53 ctermfg=white

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
au BufRead,BufNewFile,BufEnter *.js,*.tsx set ts=2 sw=2
au BufRead,BufNewFile,BufEnter *.yaml,*.yml setlocal ts=2 sw=2

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
" Status bar to show file name.
set laststatus=2
set statusline+=%F
" If a file is changed while vim has it open, and vim doesn't have unsaved changes, automatically reload file.
set autoread

" Spell-check.
au BufNewFile,BufRead *.tex set spell

" Custom mapleader.
let mapleader = ","

noremap <C-c> "+y<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-lsp
"
"    Putting this first, so python language server starts up quickly.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" python registration.
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


" typescript registration.
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
endif

let g:lsp_virtual_text_enabled = 0
let g:lsp_diagnostics_enabled = 0
" let g:asyncomplete_auto_popup = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Currently, this is only set up for one vimwiki directory.
" For work, add `wiki_2` following the instructions here:
" https://opensource.com/article/18/6/vimwiki-gitlab-notes
let g:vimwiki_list = [
    \ {'path': '~/vimwiki-personal', 'syntax': 'markdown', 'ext': '.md'}
    \ ]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_url_maxsave=0
let g:vimwiki_global_ext=0

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

" To allow for completed objects to be a diff color.
let g:vimwiki_hl_cb_checked = 2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom: latex math syntax highlighting
"
"   Enables automatic syntax highlighting of LaTeX math blocks in markdown
"   files.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow for LaTeX formatting of math blocks in Sphinx.
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quit Goyo when we leave .md files.
" autocmd BufLeave */vimwiki*.md :Goyo!

" Call Goyo whenever we run a vimwiki file.
"" autocmd BufRead,BufNewFile */vimwiki*.md :Goyo 80

" Quitting whether Goyo is active or not
"" ca wq :w<cr>:call Quit()<cr>
"" ca q :call Quit()<cr>
"" function! Quit()
""     if exists('#goyo')
""         Goyo
""     endif
""     quit
"" endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: goyo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

autocmd BufRead,BufNewFile ~/vimwiki-personal/* Goyo 120x40
autocmd BufRead,BufNewFile ~/vimwiki-personal/* set autochdir


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> t<C-n> :TestNearest -s<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: nvim-blame-line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:blamer_enabled = 1
nmap <Leader>bx :BlamerToggle<CR>
let g:blamer_delay = 100
let g:blamer_show_in_visual_modes = 0
let g:blamer_template = '<author>, <committer> • <committer-time> • <summary>'
let g:blamer_prefix = ' '


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})


nnoremap <silent> <leader><space> :GFiles<CR>
nnoremap <silent> <leader>bb :Buffers<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hotkeys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Latex compile.
map <leader>ll :w !latexmk -silent -pdf % <enter>

" Python.
autocmd FileType python nnoremap <buffer> <leader>z :exec '!python' shellescape(@%, 1)<cr>

" Allows `//` to visually search for selected text.
vnoremap // y/<C-R>"<CR>

" Paste toggle.
set pastetoggle=<F2>

" Vimwiki diary navigation.
nnoremap <C-j> :VimwikiDiaryNextDay<CR>
nnoremap <C-k> :VimwikiDiaryPrevDay<CR>

" Goyo toggle.
nmap <Leader>g :Goyo<CR>

" NERDTree toggle.
map <C-n> :NERDTreeToggle<CR>

" Buffer management.
" nmap <Leader>bb :ls<CR>:buffer<Space>
nmap <Leader>bp :bprev<CR>
nmap <Leader>bn :bnext<CR>

" Print datetime.
nnoremap <F5> "=strftime("%b %d, %Y")<CR>P
inoremap <F5> <C-R>=strftime("%b %d, %Y")<CR>

" vim-lsp definition and references.
" nnoremap <silent> gd :LspDefinition<CR>
" nnoremap <silent> gr :LspReferences<CR>
" nnoremap <silent> gp :LspPeekDefinition<CR>
" nnoremap <silent> gh :LspHover<CR>
" let g:lsp_highlight_references_enabled = 1

" Autoclose preview window when completion done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" KITE-INCOMPATIBLE
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" END KITE-INCOMPATIBLE

" Set default python path to my default venv
call coc#config('python', {'pythonPath': '/Users/robertyi/envs/default/bin/python3'})

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
