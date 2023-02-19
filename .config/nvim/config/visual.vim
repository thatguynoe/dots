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
let g:gruvbox_italicize_strings = 0
colorscheme gruvbox8
highlight EndOfBuffer guifg='#504945'

" Enable background transparency.
highlight Normal guibg=NONE
highlight VertSplit guibg=NONE

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
