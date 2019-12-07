" Set colorcheme
colorscheme gruvbox

" LARAVEL UNTILITIES
nmap <Leader>lr :e app/Http/routes.php<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader>lc :CtrlPCurWD<cr>app/Http/Controllers/
nmap <Leader>lm :CtrlPCurWD<cr>app/
nmap <Leader>lv :CtrlPCurWD<cr>resources/views/

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
