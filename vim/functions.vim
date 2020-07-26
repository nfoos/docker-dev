" Map key to toggle opt
fun! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

function! MyTabLine()
  let s = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

    let s .= ' %{MyTabLabel(' . i . ')} '

    let i = i + 1
  endwhile

  let s .= '%T%#TabLineFill#%T'
  " let s .= '%T%#TabLineFill#%='
  " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction

function MyTabLabel(n)
  let label = a:n . ': '

  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnr = buflist[winnr - 1]
  let name = bufname(bufnr)
  let buftype = getbufvar(bufnr, '&buftype')

  if buftype == 'help'
    let name = 'help:' . fnamemodify(name, ':t:r')

  elseif buftype == 'quickfix'
    let name = 'quickfix'

  elseif buftype == 'noname'
    if name =~ '\/.'
      let name = substitute(name, '.*\/\ze.', '', '')
    endif

  else
    if name =~ 'NERD_tree'
      let name = '[NT]'

    elseif tabpagenr('$') > 15
      let name = '[' . fnamemodify(name, ':e') . ']'

    elseif tabpagenr('$') > 10
      let name = fnamemodify(name, ':t')[-10:]

    elseif tabpagenr('$') > 5
      let name = fnamemodify(name, ':t')

    else
      let name = pathshorten(fnamemodify(name, ':p:~:.'))
    endif
  endif

  if name == ''
    let name = '[No Name]'
  endif

  if getbufvar(bufnr, '&modified')
    let name = '+' . name
  endif

  let label .= name

  return label
endfunction
