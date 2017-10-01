set foldmethod=marker "za to toggle fold

" Leader {{{

:let mapleader = " "

" }}}

" Basic {{{

set ignorecase " Ignore case unless you use upper case
set smartcase " Ignore case unless you use upper case
set nocompatible
set number
set tabstop=2 " Default tabs spacing
set shiftwidth=2 " Default shift spacing when using >
set expandtab
set t_Co=16
set nowrap
set shell=/bin/zsh
set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac
set ttimeout " Makes it so Shift O doesn't take so long
set ttimeoutlen=100 " Makes it so Shift O doesn't take so long
set scrolloff=1 " Makes it so you can see one line below line at all times
set incsearch " Incremental Search start search when you start typing
set wildmenu " A menu for tab completions of vim commands
set backspace=indent,eol,start
set numberwidth=2
set laststatus=2
set noshowmode
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" }}}

" Theme {{{

syntax on
colorscheme onedark

" Setting Italicize comments
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic

let g:lightline = {
    \   'active': {
    \     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
    \     'right': [ [], [ 'fugitive' ], ['lineinfo'] ]
    \   },
    \   'inactive': {
    \     'left': [ [ 'filename' ] ],
    \     'right': []
    \   },
    \   'tabline': {
    \     'left': [ [ 'tabs' ] ],
    \     'right': []
    \   },
    \   'component_visible_condition': {
    \     'readonly': '(&filetype!="help"&& &readonly)',
    \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \   },
    \   'component': {
    \     'absolutepath': '%F', 'relativepath': '%f', 'filename': '%t', 'modified': '%M', 'bufnum': '%n',
    \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \    },
    \ }
" }}}

" Cheats {{{

" map shift h and shift l to beg and end of line
noremap H ^
noremap L $

" Improve tab navigation
" nnoremap th  :tabfirst<CR>
" nnoremap tj  :tabnext<CR>
" nnoremap tk  :tabprev<CR>
" nnoremap tl  :tablast<CR>
" nnoremap tt  :tabedit<Space>
" nnoremap tn  :tabnew<CR>
" nnoremap tm  :tabm<Space>
" nnoremap td  :tabclose<CR>

" Improve splitting
" nnoremap vv  :vsplit<CR>
" nnoremap ss  :split<CR>

" }}}

" Basic Remaps {{{

" nnoremap <Leader>p "*]p
" nnoremap <Leader>P "*]P

" Reselect block after indent/outdent
vnoremap < <gv
vnoremap > >gv

if executable('ag')
	let g:ackprg = 'ag --vimgrep' " Allows us to use ag when using :Ack
endif

" Get rid of Control W to make nav easier
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Ability to paste mutliple times
xnoremap p pgvy

" Map to make it easier to source vim config file
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Easily open up vim config

" Make X an operator that removes text without placing text in the default
" registry
nmap xx "_dd
" vmap xx "_dd

" have x (removes single character) not go into the default registry
nnoremap x "_x"

" helps . work like it should in visual mode
vnoremap . :norm.<CR>

" }}}

" Wierd Commands that do cool stuff {{{

nmap <Leader>r :execute "!clear && bundle exec rspec %\\:" . line(".")<CR>
nmap <Leader>R :execute "!clear && bundle exec rspec %"<CR>

if executable('ag')
" Use Ag over Grep
set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects
" .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" toggles relative number and normal number
" function! NumberToggle()
"   if(&relativenumber == 1)
"     set number
"   else
"     set relativenumber
"   endif
" endfunc
" nnoremap <leader>f :call NumberToggle()<cr>

" Use system clipboard for yy, dd, p, etc.
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
else
	set clipboard=unnamed
endif

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
if has("unix")
	cmap w!! w !sudo tee > /dev/null %
endif

" Trim trailing spaces on save
function! TrimWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  %s/\r//ge
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()

" }}}

" Plugins {{{
call plug#begin()

Plug 'itchyny/lightline.vim' " This plugin helps create the status bar. Its a light weight.

Plug 'justinmk/vim-sneak' " Use s and S to navigate

Plug 'tpope/vim-fugitive' " Give you various git commands that open up vimdiff and other stuff

Plug 'tpope/vim-abolish' " Helps my fat fingers. Its like a spellchecker but auto corrects. Also gives you coercion which is awesome.

Plug 'Raimondi/delimitMate' " Automatically insert matching quotes, parens

" Plug 'xolox/vim-misc' " Need to figure out what this is. Should help with async tag gen.

" Plug 'xolox/vim-easytags' " Automatically creates tags - Could take up time
" 	let g:easytags_async = 1

Plug 'tpope/vim-repeat' " Makes it so you can use . to repeat plugin actions

Plug 'vim-scripts/tComment' " Easier way to comment
	map <Leader>/ :TComment<CR>

Plug 'mileszs/ack.vim' " Better than grep searcher
	let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""' " Use AG for control-p searching

Plug 'thoughtbot/pick.vim'
  let g:pick_height = 10
  nnoremap <Leader>p :call PickFile()<CR>
  nnoremap <Leader>s :call PickFileSplit()<CR>
  nnoremap <Leader>v :call PickFileVerticalSplit()<CR>
  nnoremap <Leader>t :call PickFileTab()<CR>
  nnoremap <Leader>b :call PickBuffer()<CR>
  nnoremap <Leader>] :call PickTag()<CR>

Plug 'scrooloose/nerdtree' " File explorer

Plug 'jistr/vim-nerdtree-tabs' " pulls up nerd tree on ever new tab
	map <Leader>n <plug>NERDTreeTabsToggle<CR>

Plug 'Tab-Name' " Just adds a better title to your tabs

Plug 'terryma/vim-multiple-cursors' " Multi Cursors
	let g:multi_cursor_use_default_mapping=0
	" Default mapping
	let g:multi_cursor_next_key='<C-n>'
	let g:multi_cursor_prev_key='<C-p>'
	let g:multi_cursor_skip_key='<C-x>'
	let g:multi_cursor_quit_key='<Esc>'
	let g:multi_cursor_exit_from_visual_mode=0
	let g:multi_cursor_exit_from_insert_mode=0

Plug 'tpope/vim-surround' " used for surrounding stuff with quotes ect. ysiw'

Plug 'christoomey/vim-tmux-navigator' " used for pane nav with tmux

" Syntax
Plug 'chemzqm/vim-jsx-improve'

Plug 'elixir-lang/vim-elixir'

Plug 'mxw/vim-jsx'
	let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'scrooloose/syntastic'
	let g:syntastic_javascript_checkers = ['eslint']
	let g:syntastic_mode_map = { 'mode': 'passive' }
	nnoremap <Leader>l :SyntasticCheck<CR>
	nnoremap <Leader>ll :SyntasticToggleMode<CR>
	let g:syntastic_ruby_checkers = ['rubocop']
	set statusline+=%#warningmsg#
	" set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	let g:syntastic_always_populate_loc_list = 0
	let g:syntastic_auto_loc_list = 0
	let g:syntastic_check_on_open = 0
	let g:syntastic_check_on_wq = 0
	let g:syntastic_check_on_w = 0

call plug#end()
	" }}}
