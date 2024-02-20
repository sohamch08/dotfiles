source ~/.config/nvim/user/sets.vim
source ~/.config/nvim/user/mapping.vim
source ~/.config/nvim/user/plugins.vim
luafile ~/.config/nvim/user/plugins/comments.lua
luafile ~/.config/nvim/user/plugins/nvim-tree.lua

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc


let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1


" let g:lightline = {
"       \ 'colorscheme': 'wombat'
"       \ }
let g:lightline = {
    \  'colorscheme': 'dracula',
    \  'active': {
    \    'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
    \  },
    \  'tabline': {
    \    'left': [ ['buffers'] ],
    \    'right': [ ['close'] ]
    \  },
    \  'component_expand': {
    \    'buffers': 'lightline#bufferline#buffers'
    \  },
    \  'component_type': {
    \    'buffers': 'tabsel'
    \  },
    \  'separator': { 'left': '', 'right': '' },
    \  'subseparator': { 'left': '', 'right': '' }
    \  }
let g:lightline#bufferline#enable_nerdfont=1


" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'


let g:indentLine_char = '│'
let g:vim_json_conceal=0

syntax on
filetype plugin indent on

colorscheme dracula


let g:tex_conceal = ''
let g:vimtex_syntax_conceal_disable = 1
let g:indentLine_conceallevel = 0
