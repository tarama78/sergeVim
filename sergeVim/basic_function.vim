" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    basic_function.vim                                 :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tnicolas <marvin@42.fr>                    +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2017/12/05 12:11:11 by tnicolas          #+#    #+#              "
"    Updated: 2018/02/02 14:29:47 by tnicolas         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" **************************************************************************** "
"                                      __      ___                             "
"                                      \ \    / (_)                            "
"                 ___  ___ _ __ __ _  __\ \  / / _ _ __ ___                    "
"                / __|/ _ \ '__/ _` |/ _ \ \/ / | | '_ ` _ \                   "
"                \__ \  __/ | | (_| |  __/\  /  | | | | | | |                  "
"                |___/\___|_|  \__, |\___| \/   |_|_| |_| |_|                  "
"                               __/ |                                          "
"                              |___/                                           "
"                                                                              "
" **************************************************************************** "

"""""""""""""""""""""""""""""""""""""basic function"""""""""""""""""""""""""""""
colorscheme ron
set nocompatible "more vim function
filetype off
set noautoindent "indent gestion with plugin
filetype indent plugin on
set cindent "indent for c files
set smartindent "autoindent
syn on "coloration syntax
set number "number of line
"min line visible around cursor
exe 'set so=' . g:min_number_line_ar_cur
if g:enable_mouse == 1
	set mouse=a "mouse on

else
	set mouse=
endif
if g:setHighlightLine == 1
	set cursorline "highlight  line

else
	set nocursorline
endif
set tabstop=4 "tab size
set shiftwidth=4 "tab size
set noexpandtab "no replace tab to space
set omnifunc=syntaxcomplete#Complete "autocompletion (<C-n>)
set showcmd "see command
"set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)
set showmode "mode in status bar
set shm=a "intelligent print of avertissement
set laststatus=2 "show always status bar (not only on split mode
set cmdheight=1 "size of command bar
set colorcolumn=81 "column 81 in red
set autowrite "auto save when change buffer
set clipboard=unnamed "to copy and paste
if g:highlight_search == 1
	set hlsearch "highlight search
else
	set nohlsearch
endif
set incsearch "highlight when typing command (not only after)
set nolist "disable color tab (enable with set invlist)
set listchars=tab:>- "draw this instead of tabs
set backspace=2 "backspace
set noswapfile "no swap file
set noignorecase "no ignore case
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
			\exe "normal! g`\"" | endif "remember position in file

"help <leader>h :SergeHelp
nmap <leader>h :exe "tabnew " . g:help_vim_file<CR>
command! SergeHelp exe "tabnew " . g:help_vim_file
"setting <leader>s :SergeSetting
nmap <leader>s :exe "tabnew " . g:setting_vim_file<CR>
command! SergeSetting exe "tabnew " . g:setting_vim_file
"update SergeVim :SergeUpdate [--param to save your param]
command! SergeReload !vim 'source ~/.vimrc' '+PluginInstall' '+q' '+SergeAlias' '+q'
"update SergeVim :SergeUpdate [--param to save your param]
command! -nargs=* SergeUpdate call SergeUpdateFunction(<f-args>)
function! SergeUpdateFunction(...)
	let l:i = 1
	let l:nb_arg = a:0
	let lastPwd = getcwd()
	while l:i <= l:nb_arg
		let arg_act = eval('a:' . l:i)
		if l:arg_act == '--param' || l:arg_act == '--setting' ||
					\l:arg_act == 'param' || l:arg_act == 'setting'
			exe ':!cd ' . g:pwdGitSergeVim . ' && ./update_vim.sh --param
						\&& cd ' . l:lastPwd
			return
		endif
		let l:i += 1
	endwhile
	exe ':!cd ' . g:pwdGitSergeVim . ' && ./update_vim.sh && cd ' . l:lastPwd
endfunction
"update git repository (admin only) :GitSergeUpdate [--param to save your param]
command! -nargs=* GitSergeUpdate call GitSergeUpdateFunction(<f-args>)
function! GitSergeUpdateFunction(...)
	let l:i = 1
	let l:nb_arg = a:0
	let lastPwd = getcwd()
	while l:i <= l:nb_arg
		let arg_act = eval('a:' . l:i)
		if l:arg_act == '--param' || l:arg_act == '--setting' ||
					\l:arg_act == 'param' || l:arg_act == 'setting'
			exe ':!cd ' . g:pwdGitSergeVim . ' && ./update_git.sh --param
						\&& cd ' . l:lastPwd
			return
		endif
		let l:i += 1
	endwhile
	exe ':!cd ' . g:pwdGitSergeVim . ' && ./update_git.sh && cd ' . l:lastPwd
endfunction

"auto indent whit norm comment
nmap =G :call SergeIndentComment()<CR>
function! SergeIndentComment()
	:normal G=gg
	:silent! % s/^ \*\+/\*\*/g
	:silent! % s/^\*\*\+\//\*\//g
	:normal gg
endfunction

"call a SergeFunction <C-s>
nmap <leader>z :Serge
vmap <leader>z :Serge
"binary mode
nmap <leader>b :%!xxd<CR>

"hide all python functions
let g:hide_show_python_function = 0
function! HideAllPythonFunction()
	if g:hide_show_python_function == 0
		let g:hide_show_python_function = 1
		set foldmethod=indent
		set foldlevel=1
		set foldclose=all
	else
		let g:hide_show_python_function = 0
		:normal zR
	endif
endfunction
if g:hide_python_function == 1
	call HideAllPythonFunction()
endif
command! Hide call HideAllPythonFunction() | let g:hide_python_function = 1
nmap <F8> :call HideAllPythonFunction()<CR>

command Vterm :vs | :term ++curwin

"init repo :SergeInitRepo
command! SergeInitRepo :!wget https://raw.githubusercontent.com/tnicolas42/sergeVim/master/init_repo.sh && sh init_repo.sh && rm init_repo.sh
"""""""""""""""""""""""""""""""""""""basic function"""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""function"""""""""""""""""""""""""""""""""""
"vim '+Line' to open vim with highlight line
command! Line set cursorline

"keep cursor place
let g:last_filename = expand('%')
let g:first_line_visible = line('w0') + g:min_number_line_ar_cur
let g:save_pos = getpos('.')
function! SetCursorPlaceSave()
	let g:last_filename = expand('%')
	let g:first_line_visible = line('w0') + g:min_number_line_ar_cur
	let g:save_pos = getpos('.')
endfunction
function! SetCursorPlaceGo()
	exe ':b ' . g:last_filename
	exe ':' . g:first_line_visible
	:normal zt
	call setpos('.', g:save_pos)
endfunction
"keep cursor place width arg
function! SetCursorPlaceSaveArg(last_file, last_pos, last_col, last_top)
	exe ':let g:' . a:last_file . '="' . expand('%') . '"'
"	let pos_pos = getline('.')
"	exe ':let g:' . a:last_pos . '="' . l:pos_pos . '"'
	let pos_pos = line('.')
	exe ':let g:' . a:last_pos . '=' . l:pos_pos
	let pos_col = col('.')
	:normal 0
	while matchstr(getline('.'), '\%' . col('.') . 'c.') =~# '\t'
		let pos_col += 3
		:normal l
	endwhile
	exe ':silent! normal ' . l:pos_col . '|'
	exe ':let g:' . a:last_col . '=' . l:pos_col
	let pos_top = line('w0') + g:min_number_line_ar_cur
	exe ':let g:' . a:last_top . '=' . l:pos_top
endfunction
function! SetCursorPlaceMoveArg(last1_file, last1_pos, last1_col, last1_top,
			\last2_file, last2_pos, last2_col, last2_top)
	exe ':let g:' . a:last2_file . '= g:' . a:last1_file
	exe ':let g:' . a:last2_pos . '= g:' . a:last1_pos
	exe ':let g:' . a:last2_col . '= g:' . a:last1_col
	exe ':let g:' . a:last2_top . '= g:' . a:last1_top
endfunction
function! SetCursorPlaceGoArg(last_file, last_pos, last_col, last_top)
	exe ':b ' . a:last_file
	exe ':' . a:last_top
	:normal zt
	exe ':' . a:last_pos
	exe ':silent! normal ' . a:last_col . '|'
"	exe ':silent! /^' . a:last_pos
"	exe ':silent! /sdfahkfghjasgfjakfgdjhakgf'
endfunction

"double u if updated line as changed
nmap u :call SergeU()<CR>
function! SergeU()
	let first_line_ = line('w0') + g:min_number_line_ar_cur
	:undo
	if Create42Header_if_exist() == 1 && line('.') == 9
		exe ':' . first_line_
		:normal zt
		:silent! undo
	endif
endfunction

"double <C-r> if updated line as changed
nmap <C-r> :call SergeCtrlR()<CR>
function! SergeCtrlR()
	let first_line_ = line('w0') + g:min_number_line_ar_cur
	:redo
	if Create42Header_if_exist() == 1 && line('.') == 9
		exe ':' . first_line_
		:normal zt
		:silent! redo
	endif
endfunction
"""""""""""""""""""""""""""""""""""""function"""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""copy/paste"""""""""""""""""""""""""""""""""
"copy
"	paste <leader>p
nmap <leader>p :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
"imap <leader>p <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>a
"	copy <leader>y
nmap <leader>y :.w !pbcopy<CR><CR>
vmap <leader>y :'<, '>w !pbcopy<CR><CR>
nmap <leader>d :. !pbcopy<CR><CR>
vmap <leader>d :'<, '> !pbcopy<CR><CR>
"	enable copy <leader>c
nmap <leader>c :!cat %<CR>
"""""""""""""""""""""""""""""""""""""copy/paste"""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""save/quit""""""""""""""""""""""""""""""""""
"save and quit option
"create session <F7>
nmap <F7> :wa<CR>:mksession!<CR>
"create session and quit <leader><F7>
nmap <leader><F7> :wa<CR>:mksession!<CR>:wqa<CR>
"easy save
command! W w
command! Q q
command! WQ wq
command! Wq wq
command! WA wa
command! Wa wa
command! WQA wqa
command! WQa wqa
command! Wqa wqa
command! WqA wqa
command! XA xa
command! Xa xa
"""""""""""""""""""""""""""""""""""""save/quit""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""tab buffer"""""""""""""""""""""""""""""""""
"gest tab
"	tabmove next <leader> <tab>
nmap <leader><tab> :tabmove +1<CR>
nmap <leader><C-tab> :tabmove +1<CR>
"	tabmove last <leader> <S-tab>
nmap <leader><S-tab> :tabmove -1<CR>
nmap <leader><C-S-tab> :tabmove -1<CR>

"change buffer (<C-w> + up/down/right/left || hjkl)
"	right <C-w> l
nmap <C-w><right> <C-w>l
nmap <C-w><C-l> <C-w>l
map <C-l> <C-w>l
"	left <C-w> h
nmap <C-w><left> <C-w>h
nmap <C-w><C-h> <C-w>h
map <C-h> <C-w>h
"	up <C-w> k
nmap <C-w><up> <C-w>k
nmap <C-w><C-k> <C-w>k
map <C-k> <C-w>k
"	down <C-w> j
nmap <C-w><down> <C-w>j
nmap <C-w><C-j> <C-w>j
map <C-j> <C-w>j

"auto open in vertical split (left) <leader> f
"nmap <leader>f <C-w>f<C-w>L
"imap <leader>f <esc><C-w>f<C-w>Li
"""""""""""""""""""""""""""""""""""""tab buffer"""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""Makefile"""""""""""""""""""""""""""""""""""
"make exec <F6> :MakeEx
command! MakeEx !make exec
command! Makeex !make exec
nmap <F6> :!make exec<CR>
"make re <leader><F6> :MakeRe
command! MakeRe !make re
command! Makere !make re
"other make
command! MakeRx !make reexec
nmap <leader><F6> :!make reexec<CR>
command! MakeCl !make clean
command! Makecl !make clean
command! MakeFc !make fclean
command! Makefc !make fclean
command! MakeNo !make norm
command! Makeno !make norm
command! Make !make
command! MakeAl !make
command! Makeal !make
"""""""""""""""""""""""""""""""""""""Makefile"""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""langage C""""""""""""""""""""""""""""""""""
if has('cscope')
	set cscopetag cscopeverbose

	if has('quickfix')
		set cscopequickfix=s-,c-,d-,i-,t-,e-
	endif

	cnoreabbrev csa cs add
	cnoreabbrev csf cs find
	cnoreabbrev csk cs kill
	cnoreabbrev csr cs reset
	cnoreabbrev css cs show
	cnoreabbrev csh cs help

	command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif
"""""""""""""""""""""""""""""""""""""langage C""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""other""""""""""""""""""""""""""""""""""""""
"mouse <leader>m m/a
"	disable <leader>mm
nmap <leader>mm :set mouse=<CR>
"	enable <leader>ma
nmap <leader>ma :set mouse=a<CR>
"enter in normal mode : go to insert mode then enter <CR>
"nmap <CR> i<CR>

"relative number : <F3>
nmap <F3> :set invrelativenumber<CR>
imap <F3> <esc>:set invrelativenumber<CR>

"cursor line <F4>
nmap <F4> :set invcursorline<CR>
imap <F4> <esc>:set invcursorline<CR>

"reload vimrc <leader>v
nmap <leader>v :so $MYVIMRC<CR>
nmap <leader><C-v> :so $MYVIMRC<CR>
nmap <leader>V <C-o>:so $MYVIMRC<CR>

"fast move of 5 char <S + dir>
"	fast move of 5 char right <S-right>
nmap <S-right> $
imap <S-right> <esc>A
vmap <S-right> $
"	fast move of 5 char left <S-left>
nmap <S-left> ^
imap <S-left> <esc>I
vmap <S-left> ^
"	fast move of 5 char up <S-up>
nmap <S-up> :-5<CR>
imap <S-up> <C-o>:-5<CR>
vmap <S-up> <up><up><up><up><up>
"	fast move of 5 char down <S-down>
nmap <S-down> :+5<CR>
imap <S-down> <C-o>:+5<CR>
vmap <S-down> <down><down><down><down><down>
"""""""""""""""""""""""""""""""""""""other""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""Ugo""""""""""""""""""""""""""""""""""""""""
command! Ugo echo 'pas normal'
command! Equanime :normal gg=G
command! Goinfre normal ggdG
command! Cleanstars %s/*//g
"""""""""""""""""""""""""""""""""""""Ugo""""""""""""""""""""""""""""""""""""""""
