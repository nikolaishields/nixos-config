" Navigation
let mapleader = " "

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
   
" Quicker quits
nnoremap <C-q> <C-w>q

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quick directory change
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <leader>wq :w<CR>:bd<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :terminal <Space>

" Switch between the last two files
nnoremap <Leader><Leader> <C-^>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
