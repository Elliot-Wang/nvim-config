
" Set quickfix window width
function! AdjustWindowWidth(minwidth, maxwidth)
  execute max([a:minwidth, min([line('$'), a:maxwidth])]) . 'wincmd |'
endfunction

" call AdjustWindowWidth(20, 100)

nnoremap <buffer> q :bdelete<CR>
