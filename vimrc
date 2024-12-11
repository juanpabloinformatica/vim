"----------------------------------Options -----------------------------
"encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
"General
set signcolumn="yes"
set undofile
" this will set the undodir in the same project 
set undodir="."
set undolevels=10000
set hlsearch
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set ignorecase
set smartcase
set updatetime=250
set wildmenu
"Splitting priorities
set splitbelow
set splitright
set cursorline
set number
set relativenumber
set ruler
set nocompatible
filetype plugin indent on
colorscheme retrobox
set background=dark

"---------------------------------- Plugins ------------------------------
"
" ------------------------------- Setting Plug --------------------------

"let data_dir =  '~/.vim'
"Gotten from plug plugin

"For installing plug vim plugin manager
let data_dir =  '~/.config/vim'

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()


" List your plugins here
" Plug 'tpope/vim-sensible'
" I will add vim-gitgutter
Plug 'airblade/vim-gitgutter'
" For commenting
Plug 'tpope/vim-commentary'
" For pairing brackets, parentheses .....
Plug 'Raimondi/delimitMate'
" for fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" For editorconfig
Plug 'editorconfig/editorconfig-vim'
" For Having an LSP client in vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" For C/C++ Highlighting
Plug 'bfrg/vim-c-cpp-modern'
" zoom tab
Plug 'troydm/zoomwintab.vim'
call plug#end()


" Use release branch (recommended)

"maps

let mapleader = " "
inoremap jj <ESC>
nnoremap <C-h> <C-w>h 
nnoremap <C-j> <C-w>j 
nnoremap <C-k> <C-w>k 
nnoremap <C-l> <C-w>l 
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent><leader>fg  :Rg<CR>
nnoremap <silent> <leader>ff :FZF -m<CR>


" Coc ---> autocompletition keymap
" Use tab for trigger completion with characters ahead and navigate
" " NOTE: There's always complete item selected by default, you may want to
" enable
" " no select by `"suggest.noselect": true` in your configuration file
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config
inoremap <silent><expr> <TAB>
       \ coc#pum#visible() ? coc#pum#next(1) :
             \ CheckBackspace() ? "\<Tab>" :
                   \ coc#refresh()
                   inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
 inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 inoremap <silent><expr> <c-@> coc#refresh()
" Use `[d` and `]d` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list
 nmap <silent> [d <Plug>(coc-diagnostic-prev)
 nmap <silent> ]d <Plug>(coc-diagnostic-next)
" GoTo code navigation
 nmap <silent> gd <Plug>(coc-definition)
 nmap <silent> gy <Plug>(coc-type-definition)
 nmap <silent> gi <Plug>(coc-implementation)
 nmap <silent> gr <Plug>(coc-references)
 nmap <leader>rn <Plug>(coc-rename)
" show documentation --> this is  a coc recomendation twikked with <leader>
nnoremap <silent><leader>K :call ShowDocumentation()<CR>
" Formatting selected code
xmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)
" Applying code actions to the selected code block
" " Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position
 nmap <leader>cac  <Plug>(coc-codeaction-cursor)
 " Remap keys for apply code actions affect whole buffer
 nmap <leader>cas  <Plug>(coc-codeaction-source)
 " Apply the most preferred quickfix action to fix diagnostic on the current
" line
 nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line
 nmap <leader>cl  <Plug>(coc-codelens-action)
 
" Remap keys for applying refactor code actions
 nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
 xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
 nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

 


"Functions
" coc --> functions
" I need to check this one !!!!
function! CheckBackspace() abort  
let col = col('.') - 1 
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
	else
	    call feedkeys('K', 'in')
  endif
endfunction

"Commands

"Allowing fzf passing flags
" Allow passing optional flags into the Rg command.
"    Example: :Rg myterm -g '*.md'
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep(
    \   'rg
        \ --column
        \ --line-number
        \ --no-heading
        \ --fixed-strings
        \ --ignore-case
        \ --hidden
        \ --follow
        \ --glob "!.git/*"
        \ --color "always" '.shellescape(<q-args>),
        \   fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)

" coc - doc -----> Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
 " Add `:OR` command for organize imports of the current buffer
 command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" coc comand =====> for format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

"Groups
augroup mygroup
  autocmd!
    " Setup formatexpr specified filetype(s)
       autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	         " Update signature help on jump placeholder
       autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"---> seting g:let variables ---------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" ---> Adding relative number to newtr
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro rnu"

"Useful commands
"cdo execute "normal @register_selected" | write
