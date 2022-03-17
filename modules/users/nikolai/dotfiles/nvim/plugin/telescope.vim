lua require("nikolaishields")

nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-f> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>bf :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>bf :lua require('telescope.builtin').file_browser()<CR>
nnoremap <leader>vrc :lua require('nikolaishields.telescope').search_vimrc()<CR>
nnoremap <leader>dot :lua require('nikolaishields.telescope').search_dotfiles()<CR>
