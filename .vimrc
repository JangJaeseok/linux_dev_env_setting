"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

let $vimhome=fnamemodify(resolve(expand("~/.vimrc")), ':p:h')
let $vundle=$vimhome."/bundle/Vundle.vim"

" be iMproved, required
set nocompatible

"=====================================================
"" Vundle settings
"=====================================================
filetype off		" required
set rtp+=$vundle	" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'               " let Vundle manage Vundle, required

"-------------------=== Code/Project navigation ===-------------
Plugin 'scrooloose/nerdtree'                " Project and file navigation
Plugin 'scrooloose/nerdcommenter'			" nerdcommenter
Plugin 'majutsushi/tagbar'                  " Class/module browser
Plugin 'kien/ctrlp.vim'                     " Fast transitions on project files
Plugin 'The-NERD-Tree'						" NERD Tree
Plugin 'taglist.vim'						" taglist
Plugin 'taglist-plus'						" taglist

"-------------------=== Snippets support ===--------------------
Plugin 'snipMate'							" for snipMate
Plugin 'garbas/vim-snipmate'                " Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
Plugin 'tomtom/tlib_vim'                    " dependencies #2
Plugin 'honza/vim-snippets'                 " snippets repo

"-------------------=== Languages support ===-------------------
Plugin 'tpope/vim-commentary'               " Comment stuff out
Plugin 'tpope/vim-fugitive'
Plugin 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
Plugin 'Rykka/riv.vim'                      " ReStructuredText plugin

"-------------------=== Other ===-------------------------------
Plugin 'bling/vim-airline'                  " Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
Plugin 'fisadev/FixedTaskList.vim'          " Pending tasks list
Plugin 'rosenfeld/conque-term'              " Consoles as buffers
Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
Plugin 'flazz/vim-colorschemes'             " Colorschemes
Plugin 'altercation/vim-colors-solarized'	" colors-solarized
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'

"-------------------=== Python  ===-----------------------------
Plugin 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
"Plugin 'scrooloose/syntastic'               " Syntax checking plugin for Vim


" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line

Plugin 'AutoComplPop'	" for auto complete pop
Plugin 'DoxygenToolkit.vim'	" for Doxygen
Plugin 'davidhalter/jedi-vim'	" for jedi-vim
Plugin 'mileszs/ack.vim'	" for ack

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
call vundle#end()            " required

filetype on
filetype plugin on
filetype plugin indent on


"=====================================================
"" General settings
"=====================================================
syntax enable                               " syntax highlight

set background=dark
set t_Co=256                                " set 256 colors
colorscheme molokai							" set color scheme [molokai, solarized, jellybeans, desert, wombat256mod]

set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code
set cindent
set smartindent

set cursorcolumn
set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}

set enc=utf-8	                            " utf-8 by default
set fencs=utf-8

set nobackup	                            " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile	                            " no swap files

set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

set scrolloff=10                            " let 10 lines before/after cursor during scroll

"set clipboard=unnamed                       " use system clipboard

set exrc                                    " enable usage of additional .vimrc files from working directory
set secure                                  " prohibit .vimrc files to execute shell, create files, etc...

set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

set history=100
set showcmd
set wrapscan
set nowb
set nopaste
set sm
set ignorecase
set laststatus=2
set statusline=%<%l:%v\ [%P]\ %F\ %=%a\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ %h%m%r\
set title
set fdc=3

if has("autocmd")
	if v:version > 701
		autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
		autocmd Syntax * call matchadd('Search', '\W\zs\(HELP\|DEBUG\)')
		autocmd Syntax * call matchadd('ErrorMsg', '\W\zs\(ERROR\|FATAL\)')

        autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
        autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
        autocmd FileType python,rst,c,cpp set nowrap
	endif
endif

" highlight 'long' lines (>= 80 symbols) in python files
"augroup vimrc_autocmds
"    autocmd!
"    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
"    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
"    autocmd FileType python,rst,c,cpp set nowrap
"    autocmd FileType python,rst,c,cpp set colorcolumn=80
"augroup END


map <Tab> >gv
map <S-Tab> <gv
map <F6> :tab split<cr>
nmap ,g :grep -r "<cword>" *<cr><cr>:cw<cr>
nmap ,j :vertical stjump <c-r>=expand("<cword>")<cr><cr>
nmap ,t :tab stjump <c-r>=expand("<cword>")<cr><cr>
cmap E Explor



"=====================================================
"" Temporary highlighting settings
"=====================================================
highlight HiGrp0 guibg=#bbbbff
highlight HiGrp1 guibg=#bbffbb
highlight HiGrp2 guibg=#ffbbbb

let g:MatchIdList = [0, 0, 0]

function! s:HighlightOff(GroupId)

	let sIndexInList = a:GroupId

	if g:MatchIdList[sIndexInList] != 0
		call matchdelete(g:MatchIdList[sIndexInList])
		let g:MatchIdList[sIndexInList] = 0
	endif

endfunction

function! s:HighlightOn(GroupId)

	let sIndexInList = a:GroupId
	let sGroup       = "HiGrp" . a:GroupId
	let sKeyword     = input("Keyword to
	highlight: ", expand("<cword>"))

	call s:HighlightOff(a:GroupId)

	let
	g:MatchIdList[sIndexInList] =
	matchadd(sGroup, sKeyword)

endfunction

command! -nargs=1 -complete=file HighOn call s:HighlightOn("<args>")
command! -nargs=1 -complete=file HighOff call s:HighlightOff("<args>")

hi ExtraWhitespace ctermbg=red guibg=red
mat ExtraWhitespace /\s\+$\| \+\ze\t/
au BufWinEnter * mat ExtraWhitespace /\s\+$\| \+\ze\t/
au InsertEnter * mat ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
au InsertLeave * mat ExtraWhitespace /\s\+$\| \+\ze\t/
au ColorScheme * hi ExtraWhitespace ctermbg=red guibg=red

au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\ exe "norm g`\"" |
			\ endif

"=====================================================
"" colors-solarized settings
"=====================================================
let g:solarized_termcolors=256

"=====================================================
"" Doxygen settings
"=====================================================
func! DoxOn()
	exe "Dox"
endfunction
func! DoxAuthorOn()
	exe "DoxAuthor"
endfunction
vmap <c-k> <esc>:call DoxOn() <cr>
vmap <c-l> <esc>:call DoxAuthorOn() <cr>
nmap <c-k> <esc>:call DoxOn() <cr>
nmap <c-l> <esc>:call DoxAuthorOn() <cr>

"=====================================================
"" comment settings
"=====================================================
func! CmtOn()
	exe "'<,'>norm i//"
endfunction
func! CmtOff()
	exe "'<,'>norm 2x"
endfunction
vmap <c-c> <esc>:call CmtOn() <cr>
vmap <c-x> <esc>:call CmtOff() <cr>
nmap <c-c> <esc>:call CmtOn() <cr>
nmap <c-x> <esc>:call CmtOff() <cr>

"=====================================================
"" taglist settings
"=====================================================
let Tlist_Ctags_Cmd ="/usr/bin/ctags"
let Tlist_Inc_Winwidth=0
map <F5> :TlistToggle<cr>
set tagbsearch " ctags speed up

"=====================================================
"" cscope settings
"=====================================================
nmap ,cs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap ,cg :cs find g <C-R>=expand("<cword>")<CR><CR>
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb
if filereadable("./cscope.out")
	cs add cscope.out
endif
set csverb

"=====================================================
"" ctrlp settings
"=====================================================
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore += '\v\.(exe|so|dll)$'
let g:ctrlp_custom_ignore += 'some_bad_symbolic_links'

"=====================================================
"" jedi-vim settings
"=====================================================
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

"=====================================================
"" Python settings
"=====================================================
let g:pymode = 0
let g:pymode_options_colorcolumn = 0

" python executables for different plugins
let g:pymode_python='python'
let g:syntastic_python_python_exec='python'

" rope
let g:pymode_rope=1
let g:pymode_rope_completion=1
let g:pymode_rope_complete_on_dot=1
let g:pymode_rope_auto_project=1
let g:pymode_rope_enable_autoimport=1
let g:pymode_rope_autoimport_generate=1
let g:pymode_rope_guess_project=0
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_rope_goto_definition_cmd = "new"
let g:pymode_rope_extended_complete = 1

" documentation
let g:pymode_doc=0
let g:pymode_doc_key='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" syntastic
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_enable_signs=1
"let g:syntastic_check_on_wq=0
"let g:syntastic_aggregate_errors=1
"let g:syntastic_loc_list_height=5
"let g:syntastic_error_symbol='X'
"let g:syntastic_style_error_symbol='X'
"let g:syntastic_warning_symbol='x'
"let g:syntastic_style_warning_symbol='x'
"let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python']

let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>

map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
map <Leader>g :call RopeGotoDefinition()<CR>

set completeopt=longest,menuone
function! OmniPopup(action)
	if pumvisible()
		if a:action == 'j'
			return "\<C-N>"
		elseif a:action == 'k'
			return "\<C-P>"
		endif
	endif
	return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

"=====================================================
"" Riv.vim settings
"=====================================================
let g:riv_disable_folding=1
let g:riv_python_rst_hl=0

"=====================================================
"" SnipMate settings
"=====================================================
let g:snippets_dir='~/.vim/bundle/snipMate/'

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeWinPos = "right"
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
let NERDTreeDirArrows=0
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap <F4> :NERDTreeToggle<CR>

"=====================================================
"" NERDcommenter settings
"=====================================================
let g:NERDSpaceDelims = 1		" Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1		" Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'		" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1		" Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }		" Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1		" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1		" Enable trimming of trailing whitespace when uncommenting

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=40
nnoremap <silent> <F7> :TagbarToggle<CR>

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" Tabs / Buffers settings
"=====================================================
set switchbuf=useopen
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
