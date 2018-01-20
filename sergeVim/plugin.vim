" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    plugin.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tnicolas <marvin@42.fr>                    +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2017/11/26 11:58:30 by tnicolas          #+#    #+#              "
"    Updated: 2017/12/09 23:55:52 by tnicolas         ###   ########.fr        "
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

"""""""""""""""""""""""""""""""""""""plugin"""""""""""""""""""""""""""""""""""""
"plugin
"Vundle
"	:source ~/.vimrc
"	:PluginInstall
":plugin to install plugin
command! Plugin call Plugin_install_()
function! PLugin_install_()
	:source ~/.vimrc
	:PluginInstall
endfunction
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

"Le plugin est hébergé à https://github.com/itchyny/lightline.vim
"pour la barre en bas de couleur
if g:_enablelightline == 1
	Plugin 'itchyny/lightline.vim'
endif

"gestionaire de fichier
if g:_enableNERDTree == 1
	Plugin 'scrooloose/nerdtree'
endif

"pour colorer les nom de couleur ex #FFFFFF #00FF00
if g:_enablecolorizer == 1
	Plugin 'vim-scripts/colorizer'
endif

"correction des erreurs de code
if g:_enablesyntastic == 1
	Plugin 'vim-syntastic/syntastic'
endif

"git modif
if g:_enablegitgutter == 1
	Plugin 'airblade/vim-gitgutter'
endif

if g:_enableVimagit == 1
	Plugin 'jreybert/vimagit'
endif

call vundle#end()

"	nerdtree
"		open/close nerdtree <leader>g
if g:_enableNERDTree == 1
	let g:state_NerdTree = 0
	nmap <leader>g :call NavFichier()<CR><C-w>=
	function! NavFichier()
		if (g:state_NerdTree == 0)
			:NERDTree
			let g:state_NerdTree = 1
		else
			:NERDTreeClose
			let g:state_NerdTree = 0
		endif
	endfunction
endif

"vimagit
"	:Magit || :MagitOnly to open vimagit
"	R to reload
"	<C-n> go to next change
"	S to add or remove change to commit
"	CC to set commit message
"	CC to commit
"
"	:Push to push
"	:SergeGit to open git in the first tab
if g:_enableVimagit == 1
	command! Push !Git push origin `git branch | grep "*" | cut -c 3-`
endif
command! SergeGit call SergeOpenMagit()
function! SergeOpenMagit()
	if g:_enableVimagit == 1
		:tabnew
		:MagitOnly
		:tabm 0
		:normal gt
	endif
endfunction
"""""""""""""""""""""""""""""""""""""plugin"""""""""""""""""""""""""""""""""""""
