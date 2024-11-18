" Set quickfix window height, see also https://github.com/lervag/vimtex/issues/1127
function! AdjustWindowWidth(minheight, maxheight)
  execute max([a:minheight, min([line('$'), a:maxheight])]) . 'wincmd _'
endfunction

" call AdjustWindowHeight(5, 15)

nnoremap <buffer> q :bdelete<CR>
