set concealcursor=c
set synmaxcol=3000  " For long Chinese paragraphs

set wrap
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

nnoremap <buffer> o A<CR>

" Text objects for Markdown code blocks.
xnoremap <buffer><silent> ic :<C-U>call text_obj#MdCodeBlock('i')<CR>
xnoremap <buffer><silent> ac :<C-U>call text_obj#MdCodeBlock('a')<CR>
onoremap <buffer><silent> ic :<C-U>call text_obj#MdCodeBlock('i')<CR>
onoremap <buffer><silent> ac :<C-U>call text_obj#MdCodeBlock('a')<CR>

" open toc instead of vista tag
" nnoremap <buffer><silent> tm :Toc<CR>

" Use - to turn several lines to an unordered list.
" Ref: https://vi.stackexchange.com/q/5495/15292 and https://stackoverflow.com/q/42438795/6064933.
nnoremap <buffer><silent> - :set operatorfunc=AddListSymbol<CR>g@
xnoremap <buffer><silent> - :<C-U> call AddListSymbol(visualmode(), 1)<CR>

function! AddListSymbol(type, ...) abort
  if a:0
    let line_start = line("'<")
    let line_end = line("'>")
  else
    let line_start = line("'[")
    let line_end = line("']")
  endif

  " add list symbol to each line
  for line in range(line_start, line_end)
    let text = getline(line)

    let l:end = matchend(text, '^\s*')
    if l:end == 0
      let new_text = '- ' . text
    else
      let new_text = text[0 : l:end-1] . ' - ' . text[l:end :]
    endif

    call setline(line, new_text)
  endfor
endfunction
