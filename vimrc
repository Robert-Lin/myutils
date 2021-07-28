set fenc=utf-8 
set encoding=utf-8
set fencs=utf-8,gb18030,gbk,gb2312,cp936
set guifont=DejaVu\ Sans\ Mono\ 12
set nocompatible
set history=100
set confirm
set clipboard+=unnamed
filetype on
filetype plugin on
filetype indent on
set viminfo+=!
syntax on
colorscheme desert

setlocal noswapfile
set bufhidden=hide
set linespace=0
set wildmenu
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set cmdheight=2
set backspace=2
set whichwrap+=<,>,h,l
set mouse=a
set selection=exclusive
set selectmode=key
set shortmess=atI
set report=0
set noerrorbells
set fillchars=vert:\ ,stl:\ ,stlnc:\
set showmatch
set matchtime=5
set ignorecase
set nohlsearch
set incsearch
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
set scrolloff=3
set novisualbell
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2
set formatoptions=tcrqn
" set tw=78 fo+=Mm 

set splitbelow
set splitright

" for tab completion
set wildmode=longest,list,full
set wildmenu

set number
set autoindent
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
" set expandtab
set nowrap
set smarttab
set tags=tags;
set tags+=~/.vim/systags
set autochdir

" set *.tex as TEX FILE
au BufNewFile,BufRead *.tex set filetype=tex

set nospell
if has("autocmd")
    " Add Auto Spell Check for TeX document
	" autocmd FileType tex nmap <Leader>l :make<CR> 
	autocmd FileType txt,tex,pandoc :call TextEditing()
	autocmd FileType tex nmap <Leader>v :make view<CR> 
	autocmd FileType tex nmap <Leader>c :make count<CR>
	autocmd FileType pandoc nmap <Leader>l :!markdown2pdf %<CR><CR>
	autocmd FileType pandoc nmap <Leader>b :!markdown2slides %<CR><CR>
	autocmd FileType pandoc nmap <Leader>v :!open_or_focus_pdf %<.pdf<CR><CR>

	" open markdown file in browser
	autocmd FileType pandoc nnoremap <F6> :Silent x-www-browser % <CR>

    autocmd FileType python map <F6> :!python %<CR>
    autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
    autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
    autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
    autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl setlocal textwidth=80
    " autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif
endif " has("autocmd")

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
 
let Tlist_Sort_Type = "name"
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0

" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

" NOTICE: vim option for fcitx when inputing chinese
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=100
set iminsert=0 
set imsearch=0
"set timeoutlen=150
"autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()
 
" lookup words in vim
function! Mydict()
    let expl=system('dictl ' .
                \  expand("<cword>"))
    windo if
                \ expand("%")=="diCt-tmp" |
                \ q!|endif

    pcl
    new diCt-tmp
    setlocal nomodified buftype=nofile bufhidden=wipe noswapfile
    " setlocal pvw modifiable noro
    1s/^/\=expl/
    1
    " doc window quick quit keys: 'q' and 'escape'
    set filetype=txt
    map <buffer> q :q<CR>
    " map <buffer> <Esc> :q<CR>
endfunction
nmap <Leader>t :call Mydict()<CR>

function TextEditing()
    setlocal spell
    setlocal spelllang=en_us
	setlocal wrap 
	setlocal linebreak
	setlocal display+=lastline

	" for project-local spellfile
	if filereadable(expand("%:p:h")."/new-words.utf-8.add") |
	   \    exe "setlocal spellfile+=".expand("%:p:h")."/new-words.utf-8.add" |
	   \ endif

	" dictionary for completion
	set dictionary+=/usr/share/dict/words

	" for convenience in wrap mode
	nnoremap <buffer> 0 g0
	nnoremap <buffer> ^ g^
	nnoremap <buffer> $ g$
	nnoremap <buffer> j gj
	nnoremap <buffer> k gk
	vnoremap <buffer> 0 g0
	vnoremap <buffer> ^ g^
	vnoremap <buffer> $ g$
	vnoremap <buffer> j gj
	vnoremap <buffer> k gk

	inoremap <Home> <C-o>g0
	inoremap <End> <C-o>g$
	inoremap <Down> <C-o>gj
	inoremap <Up> <C-o>gk
	" nnoremap <Home> g0
	" nnoremap <End> g$
	" nnoremap <Down> gj
	" nnoremap <Up> gk
	" vnoremap <Home> g0
	" vnoremap <End> g$
	" vnoremap <Down> gj
	" vnoremap <Up> gk
endfunction

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
nnoremap <F9> "+yy
vnoremap <F9> "+y
inoremap <F10> <Esc>"+gpa
nnoremap <F10> "+gp

" for vim diff
au FilterWritePost * if &diff | set t_Co=256 | set bg=dark | colorscheme torte | else | colorscheme desert | endif
au BufWinLeave * colorscheme desert

" pandoc
let g:pandoc_no_folding = 1

" latexbox
" let g:LatexBox_latexmk_async = 1
" let g:LatexBox_latexmk_preview_continuously = 1

function! DevNS3()
	set ts=2
	set sw=2
	set sta
	set et
	set ai
	set si
	set cin
	
	let c_no_bracket_error=1
	let c_no_curly_error=1
	let c_comment_strings=1
	let c_gnu=1
endfunction

" command -nargs=1 Head :call Head("<args>")
function! Head(file)
	" vs [No Name]
	" r !head -n 1000 a:file
	" echo a:file
	vs a:file
endfunction

" vim in tmux
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
