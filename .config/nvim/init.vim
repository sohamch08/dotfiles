source ~/.config/nvim/user/plugins.vim
source ~/.config/nvim/user/sets.vim
source ~/.config/nvim/user/mapping.vim

" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='wombat'

let NERDTreeShowHidden=1
let NERDTreeHijackNetrw=1
let g:netrw_localrmdir='rm -rf'
let g:netrw_local_delete_recursive=1

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

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

let g:indentLine_char = '│'

syntax on
filetype plugin indent on

colorscheme tokyonight


let g:tex_conceal = ''

