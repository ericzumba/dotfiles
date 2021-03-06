" ################
" General settings
" ################

syntax on
filetype plugin indent on

" Default leader key
let mapleader=','

" Show invisibles
set list

" Reload files changed outside vim
set autoread

" Show current mode down the bottom
set showmode

" The encoding displayed
set encoding=utf-8

" The encoding written to file
set fileencoding=utf-8

" #######
" Plugins
" #######

call plug#begin('~/.nvim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'benekastah/neomake'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'guns/vim-sexp'
Plug 'othree/html5.vim'
Plug 'szw/vim-tags'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" ###################
" Selecta Integration
" ###################

function! SelectaCommand(choice_command, selecta_args, vim_command)
  let dict = { 'buf': bufnr('%'), 'vim_command': a:vim_command, 'temps': { 'result': tempname() }, 'name': 'SelectaCommand' }

  function! dict.on_exit(id, code)
    bd!

    if a:code != 0
      return 1
    endif

    if filereadable(self.temps.result)
      let l:selection = readfile(self.temps.result)[0]

      exec self.vim_command." ".l:selection
    else
      echom "selecta: error: can't read selection from (".self.temps.result.")"
    endif
  endfunction

  if line('$') != 1 && getline(1) != ''
    exec 'split '.dict.buf
  endif

  call termopen(a:choice_command." | selecta ".a:selecta_args." > ".dict.temps.result, dict)

  setf dict
  startinsert
endfunction

function! SelectaBuffer()
  let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
  let buffers = map(bufnrs, 'bufname(v:val)')

  call SelectaCommand('echo "' . join(buffers, "\n") . '"', "", ":b")
endfunction

nnoremap <leader>p :call SelectaCommand("selecta-command", "", ":e")<cr>
nnoremap <leader>pt :call SelectaCommand("selecta-command", "", ":tabnew")<cr>
nnoremap <leader>ps :call SelectaCommand("selecta-command", "", ":split")<cr>
nnoremap <leader>b :call SelectaBuffer()<cr>

" ################
" Editing settings
" ################

set incsearch
set hlsearch

" Disable swap files and things like that
set noswapfile
set nobackup
set nowb

" Persistent undo
silent !mkdir ~/.nvim/backups > /dev/null 2>&1
set undodir=~/.nvim/backups
set undofile

" Completion
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=vendor/assets/**
set wildignore+=*.gem
set wildignore+=.tags
set wildignore+=log/**
set wildignore+=tmp/**

" Set min-width of buffer, very useful when spliting panes
set winwidth=80

" Wrap lines is for fools
set nowrap
set linebreak

set scrolloff=8
set listchars=tab:>\ ,trail:·,extends:>,precedes:<,nbsp:+,eol:¬

" Run Neomake after saving a file
autocmd! BufWritePost * Neomake

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']

" ###################
" Appearence settings
" ###################

" Statusbar
set statusline=\ » " Firulinha
set statusline+=\ %f\  " Filename
set statusline+=%{fugitive#statusline()} " Git info

set statusline+=%= " Separator

set statusline+=%y " File type
set statusline+=[%{strlen(&fenc)?&fenc:'none'}] " File encoding
set statusline+=[%{&ff}] " File ending
set statusline+=\ %P\ of\ %L\  " Perc. file
set statusline+=(%l\:%c) " Line info
set statusline+=\ «\  " Firula

" Help your brain to calculate line changes
set relativenumber

" Column ruler
set colorcolumn=110

" Highlight current line
set cursorline

" Colors
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

hi! LineNR ctermbg=NONE
hi! SignColumn ctermbg=NONE
hi! VertSplit ctermbg=NONE
hi! Tabline ctermbg=NONE
