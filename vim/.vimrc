"""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Configs
"""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""
" VimPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Plugins
Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'christoomey/vim-sort-motion'
Plug 'google/vim-searchindex'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf'
Plug 'prettier/vim-prettier'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale', { 'tag': 'v1.9.1' }
Plug 'Yggdroot/indentline'

" Syntax Files
Plug 'cakebaker/scss-syntax.vim'
Plug 'ianks/vim-tsx'
Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'rudes/vim-java'

" Themes
Plug 'crusoexia/vim-monokai'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme monokai

syntax on

set background=dark
set dir=/tmp
set expandtab
set hlsearch
set ignorecase
set laststatus=2
set lazyredraw
set mouse=a
set nobackup
set nocursorline
set number
set relativenumber
set shiftwidth=2
set splitbelow
set splitright
set sts=2
set tabstop=2
set t_Co=256

hi Search cterm=NONE
hi Search ctermbg=White
hi Search ctermfg=Black

" Set clipboard as shared between X session and Vim
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""

" Ale
highlight ALEError ctermbg=Blue
let g:ale_typescript_tslint_exclude_paths = ['node_modules']
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver']
\}

" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.js,*.jsp,*.jsx,*.ts,*.tsx,*.xml"
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml': 1,
  \ 'xml' : 1,
  \ 'js' : 1,
  \ 'jsx' : 1,
  \ 'jsp': 1,
  \ 'ts': 1,
  \ 'tsx': 1
  \}

" fzf
let g:fzf_layout = { 'down': '~20%' }
map <C-P> :FZF<CR>
" autocmd FileType fzf
" autocmd  FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Indent Line
let g:indentLine_char = '•'
let g:jsx_ext_required = 0

" NerdTree
let NERDTreeShowHidden = 1
map <C-\> :NERDTreeToggle<CR>

" Prettier
let g:prettier#autoformat = 0

" Python Mode
let g:pymode_python = 'python3'

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

" Vim Sort Motion
let g:sort_motion_flags = "ui"

" YouCompleteMe
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""
" See files changed before saving
function! DiffWithSaved()
  let filetype=&ft
    diffthis
      vnew | r # | normal! 1Gdd
        diffthis
          exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Key Bindings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap j jzz
nnoremap k kzz

au StdinReadPre * let s:std_in=1

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoreload file on change
set autoread
au WinEnter * checktime

" Remove trailing whitespaces
au BufWritePre * :%s/\s\+$//e

" Force Syntax highlighting for certain  file ext
au BufRead,BufNewFile *.jspf,*.tag set filetype=jsp

" Work settings for trailing newlines
" au BufRead,BufNewFile */Liferay/* setlocal noeol nofixeol sw=2 sts=2 ts=2 noet

" Set syntax to html for snapshots
au BufReadPost *.snap set syntax=jsx

" Prettier auto-format before saving async
au BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.less,*.graphql,*.md,*.vue PrettierAsync

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Macros
"""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim

" Wrap selected item in console.log
let @c='S)iconsole.log'

" Break a 3 attribute single-line tag into a multi-line tag
let @n='f xif xif xif>i'

" Break text after space into new line
let @l='f xi'

" Trim js ext off imports & add ;
let @i = 'vbbxa;'
