set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set nocompatible
set backspace=indent,eol,start
set autoindent
set shiftround

set nu
set history=250
set ruler 
set showcmd 
set showmatch
set hlsearch
set incsearch
syntax on
set background=dark
set t_Co=256
colorscheme ir_black

set bdir=~/.vimbackups
set directory=~/.vimbackups

:abbr phpQD echo "<pre>",print_r("test", 1),"</pre>";exit;
:abbr scriptsrc <script type="text/javascript" src="$1"></script>
:abbr html4 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

:abbr c_class /**
\<CR> * @class
\<CR>* @extends
\<CR>* @param
\<CR>* @constructor
\<CR>* @description
\<CR>*/

:abbr c_attr /**
\<CR> * @attribute
\<CR>* @type
\<CR>* @default
\<CR>* @description
\<CR>*/

:abbr c_prop /**
\<CR> * @property
\<CR>* @type
\<CR>* @description
\<CR>*/

:abbr c_method /**
\<CR> * @method
\<CR>* @param
\<CR>* @description
\<CR>*/

:abbr c_ev /**
\<CR> * @event
\<CR>* @description
\<CR>*/

augroup vimrcEx
au!

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event
" handler (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

augroup END 

autocmd BufNewFile,BufRead *.js compiler yui
