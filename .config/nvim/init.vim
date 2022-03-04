

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

let NERDTreeShowHidden=1

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc



let g:python_highlight_all = 1
let g:python_highlight_file_headers_as_comments = 1

let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }

source ~/.vim/plugins.vim
source ~/.vim/sets.vim


syntax on
filetype plugin indent on





nmap run !pdflatex -output-directory=build
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>


inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>

