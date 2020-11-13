""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set colorcheme
colorscheme gruvbox
set background=dark

set cursorcolumn
set cursorline
autocmd InsertEnter * set nocuc
autocmd InsertEnter * set cul
autocmd InsertLeave * set cuc
autocmd InsertLeave * set cul

" Require install vim-gtk or vim-gnome
set clipboard^=unnamed,unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" au FileType javascript set shiftwidth=2
" au FileType javascript set tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hotkeys config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Select and search selected text in corresposing search provider
function! SelectionAndCallBrowser(url) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute( l:pattern, "\n$", "", "")
    call CmdLine("!open '" . a:url . l:pattern . "'" )

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> lw :<C-u>call SelectionAndCallBrowser("https://ludwig.guru/s/")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> gg :<C-u>call SelectionAndCallBrowser("https://www.google.com/search?q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> ox :<C-u>call SelectionAndCallBrowser("https://www.oxfordlearnersdictionaries.com/search/english/?q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> aw :<C-u>call SelectionAndCallBrowser("https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation&searchQuery=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> php  :<C-u>call SelectionAndCallBrowser("http://php.net/manual-lookup.php?pattern=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> js  :<C-u>call SelectionAndCallBrowser("https://developer.mozilla.org/en-US/search?topic=js&q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> css  :<C-u>call SelectionAndCallBrowser("https://developer.mozilla.org/en-US/search?topic=css&q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> vue  :<C-u>call SelectionAndCallBrowser("https://www.google.com.vn/search?q=+site:vuejs.org/v2/guide/+")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> lrv  :<C-u>call SelectionAndCallBrowser("https://www.google.com.vn/search?q=+site:laravel.com/docs/5.7+")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> doc  :<C-u>call SelectionAndCallBrowser("https://docs.docker.com/search/?q=")<CR>/<C-R>=@/<CR><CR>


" Find  exist snippet
nmap <leader>fs :call SearchSnippetKey(input('Search Snippet: '))<cr>
function! SearchSnippetKey(key)
    call CmdLine("Ack -G ".&filetype." ".a:key." ~/.vim_runtime/sources_non_forked/vim-snippets \n")
    return
endfunction

"Find exist config
nmap <leader>fc :call SearchConfig(input('Search Config: '))<cr>
function! SearchConfig(key)
    call CmdLine("Ack ".a:key." ~/.vim_runtime/vimrcs/\n")
    return
endfunction


""""""""""""""""""""""""""""""
" insert editor config automatically
"""""""""""""""""""""""""""""
fu! InitializeEditorConfig()
    call CmdLine('!cp -r ~/.vim_runtime/setup_environment/editor_config/. '.getcwd().'/')
endfunction
nmap <leader>ic :call InitializeEditorConfig()<cr>


""""""""""""""""""""""""""""""
" CODING UNTILITIES
"""""""""""""""""""""""""""""
nmap <leader>; <Esc>A;<Esc>
imap <leader>; <Esc>A;<Esc>

" Reload buffer and discard all content is changed
map <C-m> :edit!<cr>


map <C-a> <Esc>ggVG


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fixing error  Unknown function: UltiSnips#ExpandSnippetOrJump
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck'],
\   'php': ['langserver', 'php'],
\   'yaml': 'yamllint',
\   'javascript': ['standard', 'eslint'],
\   'html': ['tidy', 'eslint'],
\}

let g:ale_html_tidy_executable = '/usr/bin/tidy'
" let g:ale_linter_aliases = {'html': ['html', 'javascript']}

" Run ALE fixe
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace', 'eslint'],
" \}
" Use a slightly slimmer error pointer
" let g:ale_sign_error = '✖'
" hi ALEErrorSign guifg=#DF8C8C
" let g:ale_sign_warning = '⚠'
" hi ALEWarningSign guifg=#F2C38F
" let g:ale_echo_cursor = 1
nmap <leader>af <Plug>(ale_fix)

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'yaml': ['prettier'],
\   'php': ['php_cs_fixer'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'html': ['prettier'],
\}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_javascript_eslint_use_global = 1
" let g:ale_javascript_prettier_options = '--no-semi --single-quote --trailing-comma none'

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|\.next\|^\.coffee\|tags'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'tags', '\.next$', '\.git$', 'node_modules', 'default\.vim']
let NERDTreeShowHidden=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => editorconfig-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
let g:EditorConfig_core_mode = 'vim_core'
" let g:EditorConfig_verbose=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-session
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_autosave_to = getcwd()
" let g:session_directory = getcwd()
" let g:session_default_name = '.session.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 1
" autocmd FileType html,css,php EmmetInstall
let g:user_emmet_leader_key=','

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagalong
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagalong_verbose = 1
let g:tagalong_additional_filetypes = ['javascript', 'js']


let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-php-namespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>pu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>t :TagbarToggle<CR>


" MAKE EASY TO EDIT CONFIG
nmap <Leader>wr :edit apps/web_admin/application/config/routes.php<cr>
" nmap <Leader>ep :e ~/.vim_runtime/vimrcs/plugins_config.vim<cr>
