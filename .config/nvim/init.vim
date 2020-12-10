" Comments in Vimscript start with a `"`.

" Download vimplug if not already present.
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p $XDG_CONFIG_HOME/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $XDG_CONFIG_HOME/nvim/autoload/plug.vim
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

" Goyo mapping.
nnoremap <silent> <Leader>g :Goyo <cr>

" netrw mapping.
nnoremap <silent> <C-N> :Vex <cr>

" Easier navigation of splits.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easier resizing of splits.
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>

" PLUGINS:
call plug#begin()

Plug 'neovim/nvim-lspconfig'                    " neovim LSP
Plug 'nvim-lua/completion-nvim'                 " neovim autocompletion
Plug 'vim-airline/vim-airline'                  " statusline
Plug 'vim-airline/vim-airline-themes'           " statusline themes
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown preview
Plug 'lervag/vimtex'			                " better LaTeX support
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
imap <silent> <c-p> <Plug>(completion_trigger)

" Set completeopt to have a better completion experience.
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion.
set shortmess+=c

" Disable LSP's hover and displays in a floating window.
let g:completion_enable_auto_hover = 0

" AIRLINE:
set noshowmode 		                                    " Hide the default mode text (e.g. -- INSERT -- below the statusline)

let g:airline_theme = 'gruvbox'                         " Set theme
let g:airline_powerline_fonts = 0                       " Disable powerline fonts
let g:airline#extensions#tabline#enabled = 1            " Enable tabline
let g:airline#extensions#tabline#fnamemod = ':t'        " Disable file paths in the tab
let g:airline#extensions#tabline#tab_min_count = 2      " Minimum of 2 tabs needed to display the tabline

" Statusline seperators and symbols.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.linenr = ''

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
" highlight Normal guibg=NONE

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

" Runs a script that cleans out tex build files whenever exiting a .tex file.
autocmd VimLeave *.tex !texclear "%"

" Automatically start Goyo when writing mail and editing linux_setup.md
autocmd BufRead,BufNewFile /tmp/neomutt*,~/OneDrive/Documents/Other/linux_setup.md :Goyo
autocmd BufRead,BufNewFile /tmp/neomutt*,~/OneDrive/Documents/Other/linux_setup.md nmap Q :Goyo <bar> x! <cr>

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
autocmd BufWritePost blocks.h !sudo make install

" Automatically source init.vim on save (and refresh Airline).
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | :AirlineRefresh

" PYTHON:
" Update and execute code in terminal.
autocmd FileType python nnoremap <buffer> <silent> <A-m>
    \ :update <bar>
    \ 10sp <bar> term python "%" <cr>

let g:python_highlight_all = 1

" MARKDOWN:
" Preview code in browser.
autocmd FileType markdown nnoremap <buffer> <silent> <A-m> :MarkdownPreview <cr>

let g:mkdp_page_title = ' ${name} '

" Sets cleaner output.
autocmd FileType markdown set conceallevel=2

" CPP:
" Update and compile code in terminal.
autocmd FileType cpp nnoremap <buffer> <silent> <A-n>
    \ :update <bar>
    \ !g++ "%" -o "%:r".out <cr>

" Execute code in terminal.
autocmd FileType cpp nnoremap <buffer> <silent> <A-m>
    \ :10sp <bar> terminal ./"%:r".out <cr>

" LaTeX:
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = 'latex'

" Turn off (on?) all autoindentation.
" let g:tex_indent_items = 1
" let g:tex_indent_brace = 1
" let g:tex_indent_and = 1
" let g:vimtex_indent_enabled = 1
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
    require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}
EOF

" Show diagnostic on hover.
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" LSP Mappings
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>
