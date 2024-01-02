set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Robert Yi (github.com/rsyi)
"
" This is my personal vimrc setup.
"
" Index:
"   - Install plugins
"   - General
"   - Plugin: NERDTree
"   - Plugin: vimwiki
"   - Custom: latex math syntax highlighting
"   - Plugin: vim-test
"   - Plugin: nvim-blame
"   - Plugin: telescope
"   - Hotkeys
"   - Nvim language server config
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
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" Frontend
Plug 'mlaursen/vim-react-snippets'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
" Better defaults: backspace through lines, search dynamically.
Plug 'tpope/vim-sensible'
" Improved file tree.
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
" Colors
Plug 'dracula/vim', { 'as': 'dracula' }
" Wiki for vim (for note-taking).
Plug 'vimwiki/vimwiki'
" Easier visual mode.
Plug 'mhinz/vim-startify'
" vim-test.
Plug 'janko/vim-test'
" vim-blame.
Plug 'APZelos/blamer.nvim'
" Fugitive: git integration (:Git)
Plug 'tpope/vim-fugitive'
" Editorconfig
Plug 'editorconfig/editorconfig-vim'
" Lsp
Plug 'neovim/nvim-lspconfig'
" Quick scope
Plug 'unblevable/quick-scope'
" vim-surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Vimspector (debugger)
Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings='HUMAN'
" Github Copilot
Plug 'github/copilot.vim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme default
set nocompatible
filetype plugin on  " Necessary for auto file detection.
set omnifunc=syntaxcomplete#Complete
syntax on  " Enable syntax highlighting.
set noswapfile  " Disable swap files.

" Allow for scrolling.
set mouse=a

" Colors.
hi MatchParen cterm=bold ctermbg=darkgray
hi LineNr ctermfg=darkgrey
hi VertSplit ctermfg=black ctermbg=black
hi Pmenu ctermbg=black guibg=black ctermfg=gray
hi PmenuSel ctermfg=white

" Font.
" Show trailing whitespace.
highlight ExtraWhitespace ctermbg=darkgray guibg=darkgray
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
au FileType python setlocal tabstop=4
au BufRead,BufNewFile,BufEnter *.hql,*.sql set filetype=sql
au FileType html,markdown :setlocal sw=2 ts=2 sts=2
au BufRead,BufNewFile,BufEnter *.js,*.tsx,*.yaml,*.yml,*.hql,*.sql,.vimrc setlocal ts=2 sw=2

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

" Custom mapleader.
let mapleader = " "

noremap <C-c> "+y<CR>

" Markdown indent use visual indent on line wrap
set breakindent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree hotkeys
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeFocus<CR>
" Auto-close tab if last file is nerdtree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Delete NERDTree buffer
let NERDTreeAutoDeleteBuffer = 1
" Check if NERDTree is open or active


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Currently, this is only set up for one vimwiki directory.
" For work, add `wiki_2` following the instructions here:
" https://opensource.com/article/18/6/vimwiki-gitlab-notes
let g:vimwiki_list = [
    \ {'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}
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

" Spell-check.
au BufNewFile,BufRead *.tex set spell
au BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c



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
highlight Blamer ctermfg=darkgrey


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: telescope

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hotkeys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Latex compile.
map <leader>ll :w !latexmk -silent -pdf % <enter>

" Python.
au FileType python nnoremap <buffer> <leader>z :exec '!python' shellescape(@%, 1)<cr>

" Allows `//` to visually search for selected text.
vnoremap // y/<C-R>"<CR>

" Vimwiki diary navigation.
nnoremap <C-j> :VimwikiDiaryNextDay<CR>
nnoremap <C-k> :VimwikiDiaryPrevDay<CR>

" Vimwiki folding
let g:vimwiki_folding='expr'

" NERDTree toggle.
map <C-n> :NERDTreeToggle<CR>

" Buffer management.
" nmap <Leader>bb :ls<CR>:buffer<Space>
nmap <Leader>bp :bprev<CR>
nmap <Leader>bn :bnext<CR>

" Print datetime.
nnoremap <F5> "=strftime("%b %d, %Y")<CR>P
inoremap <F5> <C-R>=strftime("%b %d, %Y")<CR>

" For dbt
nmap <Leader>d :w<CR>:exec '!dbt run'<CR>:e<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language server
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=Darkgrey ctermfg=darkgrey
hi LspDiagnosticsVirtualTextHint guifg=darkgrey ctermfg=darkgrey

" Underline the offending code
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline


lua << EOF

-- https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
local on_attach = function(client, bufnr)
  require'completion'.on_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
--   if client.resolved_capabilities.document_formatting then
--     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--   elseif client.resolved_capabilities.document_range_formatting then
--     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--   end

  -- Set autocommands conditional on server_capabilities
--  if client.resolved_capabilities.document_highlight then
--    vim.api.nvim_exec([[
--      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--      augroup lsp_document_highlight
--        autocmd! * <buffer>
--        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--      augroup END
--    ]], false)
--  end
end

local nvim_lsp = require('lspconfig')
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF
