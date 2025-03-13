"=====================================
" Plugin setup
"=====================================
call plug#begin()

" List your plugins here
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/rafikdraoui/jj-diffconflicts.git'
Plug 'https://github.com/romainl/vim-qf.git'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'vim-scripts/dbext.vim'
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'mrjones2014/smart-splits.nvim'
Plug 'letieu/wezterm-move.nvim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
"Plug 'hashivim/vim-terraform'
Plug 'wfxr/minimap.vim'
Plug 'terrastruct/d2-vim'
Plug 'vim-test/vim-test'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'olimorris/codecompanion.nvim'
call plug#end()

"=====================================
" codecompanion
"=====================================
lua << EOF
  require("codecompanion").setup({
    adapters = {
    llama3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "llama3", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "llama3.2",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    deepseek = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "deepseek", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "deepseek-r1",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
    qwen = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "qwen", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "qwen2.5-coder:3b",
          },
        },
      })
    end,
  },
    strategies = {
      chat = {
        adapter = "deepseek",
      },
      inline = {
        adapter = "qwen",
      },
    },
  })
EOF
"=====================================
" Theming
"=====================================
autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='soft'
let g:gruvbox_italic=1
set background=dark
set nu
set relativenumber
set hlsearch
set is

"=====================================
" Misc Configuration
"=====================================
"Basic file type stuff
syntax on
filetype plugin indent on
" use hidden buffers
set hidden!
"Mouse
set mouse=a
" spellcheck
set spell!

"=====================================
" Custom key bindings
"=====================================
" helper maps
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
" Whitespace toggle
set listchars+=space:␣
nnoremap <leader>w :set list!<CR>
" Location list maps
nnoremap <leader>lo :lope<cr>
nnoremap <leader>lc :lcl<cr>
nnoremap <leader>ll :ll<cr>
nnoremap ]l :lne<cr>
nnoremap [l :lpr<cr>
" Quickfix  maps
nnoremap <leader>co :cope<cr>
nnoremap <leader>cc :ccl<cr>
nnoremap <leader>cl :cl<cr>
nnoremap ]q :cne<cr>
nnoremap [q :cpr<cr>
" Tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap <leader>te :tabe<cr>
" Tag bar and NERDTreeToggle
nnoremap <leader>]] :TagbarToggle<cr>
nnoremap <leader>] :TagbarOpen fj<cr>
nnoremap <leader>[ :NERDTreeToggle<cr>
nnoremap <leader>m :MinimapToggle<CR>
" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

"VIMRC
nnoremap <leader>vi :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>
"telescope
nnoremap z= <cmd>Telescope spell_suggest<CR>
nnoremap <leader>F <cmd>Telescope find_files<cr>
nnoremap <leader>G <cmd>Telescope live_grep<cr>
nnoremap <leader>B <cmd>Telescope buffers<cr>
nnoremap <leader>R <cmd>Telescope lsp_references<cr>
"vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
let g:test#python#pytest#options = "--no-cov -v"
"=====================================
" ALE
"=====================================
let g:ale_python_black_options='--line-length=100' 
let g:ale_fixers = { 'python': ['autoimport', 'isort', 'black'], 'terraform': ['terraform'], }
let g:ale_fix_on_save = 1

"=====================================
" Treesitter
"=====================================
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"=====================================
" neovide
"=====================================
if exists("g:neovide")
	set guifont=Fira\ Code:h14
	let g:neovide_fullscreen = v:true
endif

"=====================================
" File type configurations
"=====================================

" Python
autocmd BufRead,BufNewFile *.py set expandtab
autocmd BufRead,BufNewFile *.py set tabstop=4
autocmd BufRead,BufNewFile *.py set shiftwidth=4
autocmd BufRead,BufNewFile */test/*.py nmap <buffer> <silent> <leader>t :TestNearest --disable-warnings<CR>
autocmd BufRead,BufNewFile */test/*.py nmap <buffer> <silent> <leader>T :TestFile --disable-warnings<CR>

" YAML
autocmd BufRead,BufNewFile *.yml set expandtab
autocmd BufRead,BufNewFile *.yml set tabstop=2
autocmd BufRead,BufNewFile *.yml set shiftwidth=2

" lua
autocmd BufRead,BufNewFile *.lua set expandtab
autocmd BufRead,BufNewFile *.lua set tabstop=2
autocmd BufRead,BufNewFile *.lua set shiftwidth=2

" terraform
autocmd BufRead,BufNewFile *.tf set filetype=terraform
autocmd BufRead,BufNewFile *.tf set expandtab
autocmd BufRead,BufNewFile *.tf set tabstop=2
autocmd BufRead,BufNewFile *.tf set shiftwidth=2

" JSON
autocmd BufRead,BufNewFile *.json set expandtab
autocmd BufRead,BufNewFile *.json set tabstop=2
autocmd BufRead,BufNewFile *.json set shiftwidth=2

" Go
autocmd BufRead,BufNewFile *.go let g:syntastic_always_populate_loc_list = 0
autocmd BufRead,BufNewFile *.go let g:syntastic_check_on_open = 0
autocmd BufRead,BufNewFile *.go set tabstop=2
autocmd BufRead,BufNewFile *.go set shiftwidth=2
