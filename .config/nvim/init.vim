


" init.vim

" specify python3 location
" let g:python3_host_prog = '$HOME\AppData\Local\Programs\Python\Python39\python.exe'
set pyx=3

" Install vim-plug if not found
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" endif

" " Run PlugInstall if there are missing plugins
" autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \| PlugInstall --sync | source $MYVIMRC
" \| endif

call plug#begin('~/.config/nvim/plugged')


"-------------------Load files-----------------

source $NVIM_CONF_DIR/nvim/base.vim
source $NVIM_CONF_DIR/nvim/mappings.vim
source $NVIM_CONF_DIR/nvim/coc-config.vim
source $NVIM_CONF_DIR/nvim/plugins.vim
source $NVIM_CONF_DIR/nvim/language-specific.vim 
source $NVIM_CONF_DIR/nvim/theming.vim 

call plug#end()

" set the colorscheme
colorscheme material
let g:lightline.colorscheme = 'material'
