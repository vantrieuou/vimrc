" Set colorcheme
colorscheme gruvbox

" set cursorcolumn
set cursorline       
autocmd InsertEnter * set nocuc
autocmd InsertEnter * set cul
autocmd InsertLeave * set cuc
autocmd InsertLeave * set cul

" Require install vim-gtk or vim-gnome
set clipboard^=unnamed,unnamedplus

" Select and search selected text in corresposing search provider 
function! SelectionAndCallBrowser(url) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute( l:pattern, "\n$", "", "")
    call CmdLine("!google-chrome '" . a:url . l:pattern . "'" )

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> lw :<C-u>call SelectionAndCallBrowser("https://ludwig.guru/s/")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> gg :<C-u>call SelectionAndCallBrowser("https://www.google.com/search?q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> php  :<C-u>call SelectionAndCallBrowser("http://php.net/manual-lookup.php?pattern=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> js  :<C-u>call SelectionAndCallBrowser("https://developer.mozilla.org/en-US/search?topic=js&q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> css  :<C-u>call SelectionAndCallBrowser("https://developer.mozilla.org/en-US/search?topic=css&q=")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> vue  :<C-u>call SelectionAndCallBrowser("https://www.google.com.vn/search?q=+site:vuejs.org/v2/guide/+")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> lrv  :<C-u>call SelectionAndCallBrowser("https://www.google.com.vn/search?q=+site:laravel.com/docs/5.7+")<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> doc  :<C-u>call SelectionAndCallBrowser("https://docs.docker.com/search/?q=")<CR>/<C-R>=@/<CR><CR>


" MAKE EASY TO EDIT CONFIG
" nmap <Leader>es :e ~/.vim_runtime/sources_non_forked/vim-snippets/snippets/
" nmap <Leader>ep :e ~/.vim_runtime/vimrcs/plugins_config.vim<cr>

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
" Current session is saved in the working directory automatically when vim is closing
" The session is restored correspondingly when vim is opened in the working directory
"""""""""""""""""""""""""""""
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

" autocmd VimLeave * call SaveSess()
nmap <leader>ss :call SaveSess()<cr>
imap <leader>ss :call SaveSess()<cr>


" nmap <leader>rs :call RestoreSess()<cr>
" imap <leader>rs :call RestoreSess()<cr>
autocmd VimEnter * nested call RestoreSess()


""""""""""""""""""""""""""""""
" CODING UNTILITIES 
"""""""""""""""""""""""""""""
nmap <leader>; <Esc>A;<Esc>
imap <leader>; <Esc>A;<Esc>

" Reload buffer and discard all content is changed
map <C-F5> :edit!<cr>
map <C-a> <Esc>ggVG


" LARAVEL UNTILITIES
nmap <Leader>lr :e app/Http/routes.php<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader>lc :CtrlPCurWD<cr>app/Http/Controllers/
nmap <Leader>lm :CtrlPCurWD<cr>app/
nmap <Leader>lv :CtrlPCurWD<cr>resources/views/



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

