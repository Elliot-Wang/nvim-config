" Tabs of Windows
nnoremap tn :tabe<CR>          	" 打开新选项卡
nnoremap tc :tabclose<CR>       " 关闭选项卡
nnoremap tH :-tabnext<CR>	    " 到左边的选项卡
nnoremap tL :+tabnext<CR>	    " 到右边的选项卡

" Buffers
noremap th :bp!<CR>
noremap tl :bn!<CR>
noremap td :bd<CR>
noremap tD :bd!<CR>

" Split Windows
nnoremap s <nop>
nnoremap sk :set splitbelow<CR>:split<CR>	  	" 下分屏
nnoremap sj :set nosplitbelow<CR>:split<CR>		" 上分屏
nnoremap sl :set nosplitright<CR>:vsplit<CR>	" 右分屏
nnoremap sh :set splitright<CR>:vsplit<CR>		" 左分屏
nnoremap sL <C-W>L 	                    " 左右分屏换竖向分屏
nnoremap sK <C-W>K 	                    " 竖向分屏换左右分屏
nnoremap sJ <C-W>J		                " 竖向分屏换左右分屏
nnoremap sH <C-W>H		                " 左右分屏换竖向分屏
nnoremap sc <C-W>c                              " 关闭当前分屏

" Save and exit
nnoremap S :w<CR>
nnoremap Q :bd<CR>

nnoremap ZS :xa!<CR>
nnoremap ZQ :qa!<CR>
" vim default
nnoremap ZZ :x<CR>

" Move
noremap H ^
noremap L $
noremap J 15jzz
noremap K 15kzz
