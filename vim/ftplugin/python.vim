" Highlight all Python syntax groups
let python_highlight_all = 1

" Helper function for getting the next non-blank line for folding
function! NextNonBlankLine(lnum)
    let numlines = line('$')  " Get total lines in file
    let current = a:lnum + 1  " Set current line to next line

    " Get the linenumber of next non-whitespace line
    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif
        let current += 1
    endwhile

    " Return -2 upon reaching the of the file
    return -2
endfunction

" Helper function for getting indent folding
function! IndentLevel(lnum)
    let indentlevel = indent(a:lnum) / &shiftwidth
    return min([indentlevel, 1])  " Do not nest folds
endfunction

" Main folding function
function! PythonFold(lnum)

    " Fold import statements
    if getline(a:lnum) =~? '\v^import'
        return 1
    elseif getline(a:lnum) =~? '\v^from'
        return 1
    endif

    " Fold blank lines with later lines
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    " Get indentation level of current line and next non-blank line
    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    " Compare current and next indentation and set fold level as appropriate
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif

    return '0'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=PythonFold(v:lnum)
