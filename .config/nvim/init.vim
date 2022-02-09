" Comments in Vimscript start with a `"`.

" Download vimplug if not already present.
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * :PlugInstall
endif

" MAPPINGS:
" Remap leader.
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Exit terminal mode.
tnoremap <Esc> <C-\><C-n>

" Remove search highlight.
nnoremap <silent> S :nohlsearch<cr>

" Mapping for quitting quickly (and unmap Q for Ex mode).
nnoremap <silent> Q :qa!<cr>

" Open a terminal.
nnoremap <silent> <Leader>t :10sp <bar> terminal<cr>

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

" Function for toggling the bottom statusbar:
let s:hidden_all_bar = 0
function! ToggleBar()
    if s:hidden_all_bar == 0
        let s:hidden_all_bar = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all_bar = 0
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <silent> <leader>h :call ToggleBar()<cr>

" Spellchecker mapping.
nnoremap <silent> <Leader>o :set spell!<cr>

" Mappings to navigate buffers.
nnoremap <silent> <Leader>b :ls<cr>:buffer<Space>
nnoremap <silent> <Leader>d :bdelete!<cr>

" Replace all mapping.
nnoremap <Leader>r :%s//g<Left><Left>

" Save mapping.
nnoremap <silent> <Leader>w :update<cr>

" Execute the compiler script.
nnoremap <silent> <Leader>f :update <bar> silent !compiler "%"<cr>

" Open output.
nnoremap <silent> <Leader>j :silent !opout "%"<cr>

" Goyo mapping.
nnoremap <silent> <Leader>g :Goyo<cr>

" netrw mapping.
nnoremap <silent> <C-n> :Vexplore<cr>

" FZF mapping.
nnoremap <silent> <Leader>e :FZF<cr>

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
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

Plug 'neovim/nvim-lspconfig'                                " neovim LSP
Plug 'hrsh7th/nvim-cmp'                                     " neovim autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'lervag/vimtex'                                        " better LaTeX support
Plug 'nvim-lualine/lualine.nvim'                            " statusline
Plug 'jreybert/vimagit'                                     " git integration
Plug 'tpope/vim-surround'                                   " better {} [] () manipulation
Plug 'tpope/vim-commentary'                                 " better comment manipulation
Plug 'junegunn/goyo.vim'                                    " distraction free editing
Plug 'junegunn/vim-easy-align'                              " aligns text
Plug 'unblevable/quick-scope'                               " better line navigation
Plug 'psliwka/vim-smoothie'                                 " smooth scrolling
Plug 'morhetz/gruvbox'                                      " colorscheme

call plug#end()

" NVIM CMP:
" Set completeopt to have a better completion experience.
set completeopt=menuone,noinsert,noselect

" LUALINE:
" Disables -- INSERT -- and more in the command line.
set noshowmode

" Display 'MI' when both tab and spaces are used for indenting the current buffer
lua << EOF
    function MixedIndent()
        local space_indent = vim.fn.search([[\v^ +]], 'nw') > 0
        local tab_indent = vim.fn.search([[\v^\t+]], 'nw') > 0
        local mixed = (space_indent and tab_indent)
                       or vim.fn.search([[\v^(\t+ | +\t)]], 'nw') > 0
        return mixed and 'MI' or ''
    end
EOF

lua << EOF
require'lualine'.setup {
    options = {
        icons_enabled = false,
    },
    sections = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_z = { 'location', MixedIndent },
    },
}
EOF

" MAGIT:
nnoremap <silent> <Leader>m :Magit<cr>

" GOYO:
autocmd! User GoyoLeave nested highlight Normal guibg=NONE

" SMOOTHIE:
" Even smoother settings.
let g:smoothie_update_interval = 30
let g:smoothie_base_speed = 50

" QUICKSCOPE:
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" EASYALIGN:
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" VISUAL:
" Enable filetype specific mappings and more.
filetype plugin on

" Set cursor 4 lines away from the edges of the screen.
set scrolloff=4

" Enable terminal gui colors.
set termguicolors

" Show relative line numbers.
set number relativenumber

" Enable transparent sign column.
autocmd ColorScheme * highlight! link SignColumn LineNr

" Set theme.
let g:gruvbox_invert_selection = 0
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 0
colorscheme gruvbox

" Enable background transparency.
highlight Normal guibg=NONE

" Set title.
set title titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

" Enable linebreaking at words, not characters.
set linebreak

" Set horizontal splits to automatically open to the right and below.
set splitright splitbelow

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

" Turn off autoindentation.
filetype indent off

" Disable automatic comment insertion.
autocmd FileType * setlocal formatoptions-=cro

" Set spellchecker language.
set spelllang=en_us

" Enable folding.
set foldmethod=indent
set foldlevel=99

" Allow incrementing of letters.
set nrformats+=alpha

" Ensure files are read as what I want:
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff

" Automatically remove trailing whitespace on save and reset cursor position.
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Remove swap files.
set noswapfile

" MISCELLANEOUS:
" Enables a global clipboard.
set clipboard+=unnamedplus

" Enable mouse support.
set mouse=a

" Configure netrw.
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Ignore some filetypes.
set wildignore+=*.out,*.exe,*.pdf,*.doc*,*.aux

" Enable Goyo by default for mutt and markdown writing
autocmd VimEnter /tmp/neomutt*,*.md :Goyo
autocmd BufRead,BufNewFile /tmp/neomutt*,*.md nnoremap <silent> ZZ :Goyo <bar> x!<cr>

" When shortcut files are updated, update shortcuts with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Automatically recompile suckless software on save.
autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/ ; sudo make install
autocmd BufWritePost ~/.local/src/st/config.h !cd ~/.local/src/st/ ; sudo make install
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/ ; sudo make install && { killall -q dwmblocks ; setsid dwmblocks & }

" Automatically source init.vim on save.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" LaTeX:
" Runs a script that cleans out tex build files whenever exiting a .tex file.
autocmd VimLeave *.tex !texclear "%"

let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
let g:vimtex_indent_enabled = 0

" TREESITTER:
lua << EOF
    require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "cpp", "lua", "python", "html" },
        highlight = {
            enable = true,
        },
        indent = {
            enable = false,
        },
    }
EOF

" NVIM LSP AND CMP:
" Note: LSP should be instantiated after your colorscheme
lua << EOF
    -- DIAGONOSTICS
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            update_in_insert = false,
        }
    )

    -- NVIM-CMP
    local cmp = require'cmp'
    cmp.setup({
        mapping = {
            ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
        },

        sources = {
            { name = 'nvim_lsp' }
        }
    })

    local custom_lsp_attach = function(client)
        -- Open diagnostic, and go to next and previous diagnostics
        vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>a', '<cmd>lua vim.diagnostic.open_float(0, {scope = "cursor"}, {focus = false})<cr>', {noremap = true})
        vim.api.nvim_buf_set_keymap(0, 'n', ']e', '<cmd>lua vim.diagnostic.goto_next()<cr>', {noremap = true})
        vim.api.nvim_buf_set_keymap(0, 'n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<cr>', {noremap = true})

        -- LSP Mappings
        vim.api.nvim_buf_set_keymap(0, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', {noremap = true})
        vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {noremap = true})
        vim.api.nvim_buf_set_keymap(0, 'n', 'gR', '<cmd>lua vim.lsp.buf.references()<cr>', {noremap = true})
        vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', {noremap = true})
    end

    -- LSP SERVERS
    require('lspconfig')['texlab'].setup({
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = custom_lsp_attach
    })
EOF
