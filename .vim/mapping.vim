" Maps leader key
let mapleader = " "

" Move Between Buffers
map <C-Right>   :bnext<CR>
map <C-Left>    :bprevious<CR>

" Opens file explorer
map <leader>e   :Lex 20<CR>

" Move between splits
map <C-h>       <C-w>h
map <C-j>       <C-w>j
map <C-k>       <C-w>k
map <C-l>       <C-w>l

"Resize splits
noremap <silent> <C-S-h> :vertical resize +1<CR>
noremap <silent> <C-S-l> :vertical resize -2<CR>
noremap <silent> <C-S-k> :resize +1<CR>
noremap <silent> <C-S-j> :resize -2<CR>

" Comments line
map <leader>/   :Commentary<CR>

" Saves the file
map <C-s>       :w<CR>

" Closes a buffer
map zz          :bd<CR>

" Movement keymaps
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" Moving a line or a chunk of lines
vnoremap <silent> <A-j> :m .+2<CR>gv=gv
vnoremap <silent> <A-k> :m .-2<CR>gv=gv
nnoremap <silent> <A-j> :m .+2<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==

