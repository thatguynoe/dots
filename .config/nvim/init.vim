" Comments in Vimscript start with a `"`.

" Download vimplug if not already present.
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

" MAPPINGS:
" Remap leader.
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Exit terminal mode.
tnoremap <Esc> <C-\><C-n>

" Remove search highlight.
nnoremap <silent> S :nohlsearch <cr>

" Mapping for quitting quickly (and unmap Q for Ex mode).
nnoremap <silent> Q :qa! <cr>

" Open a terminal.
nnoremap <silent> <Leader>t :10sp <bar> terminal <cr>

" Keep selection after tabbing and remap <TAB> to tab.
vnoremap > >gv
vnoremap < <gv

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <Tab> >>
nnoremap <S-Tab> <<

" Easier navigation of continuous lines.
nnoremap <C-A-j> gj
nnoremap <C-A-k> gk

" Spellchecker mapping.
nnoremap <silent> <Leader>o :set spell! <cr>

" Mappings to navigate buffers.
nnoremap <silent> <Leader>n :bnext! <cr>
nnoremap <silent> <Leader>p :bprevious! <cr>
nnoremap <silent> <Leader>d :bdelete! <cr>

" Delete previous and next buffers.
nnoremap <silent> <Leader>bh :bprevious! <bar> bdelete! <cr>
nnoremap <silent> <Leader>bl :bnext! <bar> bdelete! <cr>

" Execute the compiler script.
nnoremap <silent> <Leader>f :update <bar> silent !compiler "%" <cr>

" Open output.
nnoremap <silent> <Leader>j :silent !opout "%" <cr>

" Goyo mapping.
nnoremap <silent> <Leader>g :Goyo <cr>

" netrw mapping.
nnoremap <silent> <C-n> :Vex <cr>

" Easier navigation of splits.
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Easier resizing of splits.
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>

" PLUGINS:
call plug#begin()

Plug 'neovim/nvim-lspconfig'                    " neovim LSP
Plug 'nvim-lua/completion-nvim'                 " neovim autocompletion
Plug 'lervag/vimtex'                            " better LaTeX support
Plug 'itchyny/lightline.vim'                    " statusline
Plug 'mengelbrecht/lightline-bufferline'        " bufferline
Plug 'tpope/vim-surround'                       " better {} [] () manipulation
Plug 'tpope/vim-commentary'                     " better comment manipulation
Plug 'junegunn/goyo.vim'                        " distraction free editing
Plug 'unblevable/quick-scope'                   " better line navigation
Plug 'octol/vim-cpp-enhanced-highlight'         " better c++ syntax highlighting
Plug 'vim-python/python-syntax'                 " better python syntax highlighting
Plug 'psliwka/vim-smoothie'                     " smooth scrolling
Plug 'morhetz/gruvbox'                          " colorscheme

call plug#end()

" NVIM COMPLETION:
" Use completion-nvim in every buffer.
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Map <c-p> to manually trigger completion
imap <silent> <C-p> <Plug>(completion_trigger)

" Set completeopt to have a better completion experience.
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion.
set shortmess+=c

" Disable LSP's hover and displays in a floating window.
let g:completion_enable_auto_hover = 0

" Set to sort by length instead of alphabet.
let g:completion_sorting = "length"

" LIGHTLINE:
" Disables -- INSERT -- and more in the command line.
set noshowmode

" Enables the tabline.
set showtabline=2

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
          \ 'tabline': {
          \   'left': [ ['buffers'] ],
          \   'right': [],
          \ },
          \ 'component_expand': {
          \   'buffers': 'lightline#bufferline#buffers'
          \ },
          \ 'component_type': {
          \   'buffers': 'tabsel'
          \ }
      \ }

let g:lightline#bufferline#min_buffer_count = 2
let g:lightline.component = { 'filename': '%F' }

" GOYO:
autocmd! User GoyoLeave nested highlight Normal guibg=NONE

" SMOOTHIE:
" Even smoother settings.
let g:smoothie_update_interval = 30
let g:smoothie_base_speed = 20

" QUICKSCOPE:
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" VISUAL:
" Enable filetype specific mappings and more.
filetype plugin on

" Turn on syntax highlighting.
syntax enable

" Set cursor 4 lines away from the edges of the screen.
set scrolloff=4

" Enable terminal gui colors.
set termguicolors

" Show relative line numbers.
set number relativenumber

" Set theme.
let g:gruvbox_invert_selection = 0
colorscheme gruvbox

" Enable (or disable) background transparency.
highlight Normal guibg=NONE

" Enable linebreaking at words, not characters.
set linebreak

" Set horizontal splits to automatically open to the right and below.
set splitright splitbelow

" Disable end of file blank line.
autocmd FileType * setlocal noendofline nofixendofline

" Allow hiding buffers that have unsaved changes.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters.
set ignorecase smartcase

" EDITING:
set expandtab       " Converts tabs into spaces
set tabstop=4       " Sets tabbing to 4 spaces
set softtabstop=4   " Sets normal mode tabbing to 4 spaces
set shiftwidth=4    " Sets tabbing to 4 spaces

" Set smarter indentation.
set smartindent

" Disable automatic comment insertion.
autocmd FileType * setlocal formatoptions-=cro

" Set spellchecker language.
set spelllang=en_us

" Enable folding.
set foldmethod=indent
set foldlevel=99

" Allow incrementing of letters.
set nrformats+=alpha

" Limit columns at 80 characters (except for mail and markdown files).
autocmd FileType * setlocal textwidth=80
autocmd FileType mail,markdown setlocal textwidth=0

" Automatically remove trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Remove swap files.
set noswapfile

" MISCELLANEOUS:
" Enables a global clipboard.
set clipboard=unnamedplus

" Automatically set working directory.
set autochdir

" Enable mouse support.
set mouse=a

" Configure netrw.
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Automatically recompile dwm/dwmblocks/st on save.
autocmd BufWritePost config.h !sudo make install

" Automatically source init.vim on save.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" PYTHON:
" Update and execute code in terminal.
autocmd FileType python nnoremap <buffer> <silent> <Leader>f :10sp <bar> terminal python "%" <cr>

let g:python_highlight_all = 1

" MARKDOWN:
" Sets cleaner output.
autocmd FileType markdown set conceallevel=2

" CPP:
" Update and compile code in terminal.
autocmd FileType cpp nnoremap <buffer> <silent> <Leader>f :!compiler "%" <cr>

" Execute code in terminal.
autocmd FileType cpp nnoremap <buffer> <silent> <Leader>j :10sp <bar> terminal ./"%:r".out <cr>

" LaTeX:
let g:vimtex_view_general_viewer = 'zathura'
let g:tex_flavor = 'latex'

" Runs a script that cleans out tex build files whenever exiting a .tex file.
autocmd VimLeave *.tex !texclear "%"

" Turn off (on?) all autoindentation.
filetype indent off

" NVIM LSP:
" Note: LSP must be instantiated after your colorscheme
lua << EOF
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            update_in_insert = false,
        }
    )

    require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.texlab.setup{on_attach=require'completion'.on_attach}
EOF

" Show diagnostic on hover.
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" LSP Mappings
nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>
