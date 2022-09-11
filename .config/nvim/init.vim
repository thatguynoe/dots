" Comments in Vimscript start with a `"`.

" MAPPINGS:
" Remap leader.
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Exit terminal mode.
tnoremap <Esc> <C-\><C-n>

" Mapping for quitting quickly (and unmap Q for Ex mode).
nnoremap <silent> Q :qa!<cr>

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
Plug 'L3MON4D3/LuaSnip'                                     " snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'lervag/vimtex'                                        " better LaTeX support
Plug 'nvim-lualine/lualine.nvim'                            " statusline
Plug 'jreybert/vimagit'                                     " git integration
Plug 'tpope/vim-surround'                                   " better {} [] () manipulation
Plug 'tpope/vim-commentary'                                 " better comment manipulation
Plug 'folke/zen-mode.nvim'                                  " distraction free editing
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

lua << EOF
-- Display 'MI' when both tab and spaces are used for indenting the current buffer
function MixedIndent()
  local space_indent = vim.fn.search([[\v^ +]], 'nw') > 0
  local tab_indent = vim.fn.search([[\v^\t+]], 'nw') > 0
  local mixed = (space_indent and tab_indent)
                 or vim.fn.search([[\v^(\t+ | +\t)]], 'nw') > 0
  return mixed and 'MI' or ''
end

-- Display what 'spelllang' is set to when spellchecking is active
function Spell()
  if not vim.wo.spell then
    return ''
  end
  return vim.api.nvim_get_option('spelllang')
end

require'lualine'.setup {
  options = {
    icons_enabled = false,
  },
  sections = {
    lualine_c = {
       { 'filename', path = 1 },
       { Spell }
    },
    lualine_z = { 'location', MixedIndent },
  }
}
EOF

" MAGIT:
nnoremap <silent> <Leader>m :Magit<cr>

" ZENMODE:
lua << EOF
  require("zen-mode").setup {
    window = {
      backdrop = -1,
      width = 80,
      height = 0.85,
      options = { number = false, relativenumber = false }
    }
  }
EOF

nnoremap <silent> <Leader>g :ZenMode<cr>

" SMOOTHIE:
" Even smoother settings.
let g:smoothie_update_interval = 30
let g:smoothie_base_speed = 50

" QUICKSCOPE:
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Modify colors:
augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#5fffff' gui=bold
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#259e3d' gui=bold
augroup END

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

" Set sign column in number column.
set signcolumn=number

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
function TrimWhiteSpace()
    let cursor_pos = getpos(".")
    %s/\s\+$//e
    call cursor(cursor_pos[1], cursor_pos[2])
endfunction

autocmd BufWritePre * call TrimWhiteSpace()

" Remove swap files.
set noswapfile

" The following variables and functions make nvim's terminal more comfortable
" by providing functionality to toggle a terminal and execute code in a
" terminal. It also reuses an open terminal to run commands.
let s:terminal_window = -1
let s:terminal_buffer = -1
let s:terminal_job_id = -1

function! TerminalOpen()
    " Check if buffer exists, if not create a window and a buffer
    if !bufexists(s:terminal_buffer)
        " Creates a window call terminal
        new terminal

        " Moves to the window the right the current one
        wincmd J
        resize 15
        let s:terminal_job_id = termopen($SHELL, { 'detach': 1 })

        " Change the name of the buffer to `Terminal`
        silent file Terminal

        " Gets the id of the terminal window
        let s:terminal_window = win_getid()
        let s:terminal_buffer = bufnr('%')

        " The buffer of the terminal won't appear in the list of the buffers
        " when calling :buffers command
        set nobuflisted
    else
        if !win_gotoid(s:terminal_window)
            sp

            " Moves to the window below the current one
            wincmd J
            resize 15
            buffer Terminal

            " Gets the id of the terminal window
            let s:terminal_window = win_getid()
        endif
    endif

    " No line numbers
    set nonumber norelativenumber
endfunction

function! TerminalClose()
    if win_gotoid(s:terminal_window)
        " Close the current window
        hide
    endif
endfunction

function! TerminalToggle()
    if win_gotoid(s:terminal_window)
        call TerminalClose()
    else
        call TerminalOpen()
    endif
endfunction

function! TerminalExec(cmd)
    if !win_gotoid(s:terminal_window)
        call TerminalOpen()
    endif

    " Run command
    call jobsend(s:terminal_job_id, a:cmd . "\n")
    normal! G
    wincmd p
endfunction

" Toggle a terminal.
nnoremap <silent> <Leader>t :call TerminalToggle()<cr>

" MISCELLANEOUS:
" Enables a global clipboard.
set clipboard+=unnamedplus

" Enable mouse support.
set mouse=nvc

" Configure netrw.
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Ignore some filetypes.
set wildignore+=*.out,*.exe,*.pdf,*.doc*,*.aux

" Enable ZenMode by default for mutt and markdown writing
autocmd VimEnter /tmp/neomutt*,*.md :ZenMode
autocmd BufRead,BufNewFile /tmp/neomutt*,*.md nnoremap <silent> ZZ :close <bar> x!<cr>

" When shortcut files are updated, update shortcuts with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Automatically recompile suckless software on save.
autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/ ; sudo make install
autocmd BufWritePost ~/.local/src/st/config.h !cd ~/.local/src/st/ ; sudo make install
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/ ; sudo make install && { killall -q dwmblocks ; setsid dwmblocks & }

" Automatically source init.vim on save.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC

" Call :nohlsearch when entering insert mode.
autocmd! InsertEnter * call feedkeys("\<Cmd>nohlsearch\<cr>" , 'n')

" LaTeX:
" Runs a script that cleans out tex build files whenever exiting a .tex file.
autocmd BufWipeout,VimLeave *.tex !texclear "%"

let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 0
let g:vimtex_compiler_latexmk = { 'options' : [ '-synctex=0' ] }
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
  local luasnip = require("luasnip")
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-k>'] = cmp.mapping(function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { "i", "s" }),
      ['<C-j>'] = cmp.mapping(function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
      end, { "i", "s" }),
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' }
    }
  })

  local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }

    -- No virtual text for diagnostics
    vim.diagnostic.config({
      virtual_text = false
    })

    -- Open diagnostic, and go to next and previous diagnostics
    vim.keymap.set('n', '<Leader>a', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, bufopts)

    -- LSP Mappings
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
  end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'texlab' }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach
    }
  end
EOF
