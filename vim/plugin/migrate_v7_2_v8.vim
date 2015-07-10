" Title:         Migrate_Odoo_728
" Author:        Sathors   sathors@free.fr
"
" Goal:          A small script to help migrating Odoo fields from the API 7
"                to the 8
" Usage:         This file should reside in the plugin directory and be
"                automatically sourced.
"
" License:       GPLv3
" Documentation: Inside this file
"
" Version:       0.1

" Initialization {{{
if !exists("g:MigrateOdooFieldsModule")
    let g:MigrateOdooFieldsModule = 'fields'
endif

let s:parsing_pattern = '\v\s*''(\w+)''\s*:\s*fields\.(\w+)\(.*'
" }}}

function! GetFieldName(line)
    return matchlist(a:line, s:parsing_pattern)[1]
endfunction

function! GetFieldType(line)
    return matchlist(a:line, s:parsing_pattern)[2]
endfunction

function! GetTypeAttr(arguments)
    return matchlist(a:arguments, '\v.*, type\=''(\w+)''.*')[1]
endfunction

function! GetFunctionName(arguments)
    echom a:arguments
    return matchlist(a:arguments, '\v(\w+)\, .*')[1]
endfunction

function! CleanArguments(arguments)
    let arguments = a:arguments
    " Remove newlines
    let arguments = substitute(arguments, '\n', '', 'g')
    " Remove additional blanks
    let arguments = substitute(arguments, '\v\s+', ' ', 'g')
    " Replace double quotes by simple ones
    let arguments = substitute(arguments, '\v"', '''', 'g')
    " Add a space after every comma
    return substitute(arguments, '\v,\s*', ', ', 'g')
endfunction

function! StripArgument(arguments, argument_to_strip)
    return substitute(a:arguments, '\v, ' . a:argument_to_strip . '\=''\w+''', '', '')
endfunction

function! CleanFunctionArguments(arguments)
    let new_arguments = StripArgument(a:arguments, 'type')
    " Remove the method= argument
    let new_arguments = StripArgument(a:arguments, 'method')
    " Remove the function name
    return substitute(new_arguments, '\v\w+, ', '', '')
endfunction

function! MigrateNormalField()
    let unnamed_register = @@

    let line = getline(".")
    " check that we are indeed in a v7 field line
    if line !~# '\v\s*''\w+''\s*:\s*fields\..*'
        echom "This line is not a field"
        return 1
    endif
    let field_name = GetFieldName(line)
    let field_type = GetFieldType(line)
    " check that the field type is indeed a normal field type
    " Select the arguments
    execute "normal! " . '^/\v\(' . "\<cr>di("
    let arguments = CleanArguments(@@)
    " Delete the line
    normal! dd
    if field_type == 'function'
        echom "The field is a function"
        let field_type = GetTypeAttr(arguments)
        let function_name = GetFunctionName(arguments)
        let arguments = CleanFunctionArguments(arguments)
        call PrintFunctionField(field_type, field_name, arguments)
        execute "normal! ?" . 'def.*' . function_name . "\<cr>"
    elseif field_type == 'related'
        echom "The field is related"
        let field_type = GetTypeAttr(arguments)
        let new_arguments = ParseRelatedArguments(arguments)
        let related_args = new_arguments[0]
        let remaining_args = new_arguments[1]
        let remaining_args = StripArgument(remaining_args, 'type')
        let arguments = BuildRelatedArguments(related_args, remaining_args)
        let arguments = CleanFunctionArguments(arguments)
        call PrintNewField(field_type, field_name, arguments)
    else
        echom "The field is of normal type"
        call PrintNewField(field_type, field_name, arguments)
    endif

    let @@ = unnamed_register
endfunction

function! BuildRelatedArguments(related_args, remaining_args)
    let result = 'related=''' . join(a:related_args, '.') 
    return result . ''', ' . a:remaining_args
endfunction

function! ParseRelatedArguments(arguments)
    " Return a list of the related fields, and the remaining arguments
    " as a string.
    let remaining_args = a:arguments
    let continue = 1
    let related_args = []
    let pattern = '\v^''(\w{-})'',\s*(.*)'
    while continue
        let my_list = matchlist(remaining_args, pattern)
        if len(my_list) > 1
            call add(related_args, my_list[1])
            let remaining_args = my_list[2]
        else
            let continue = 0
        endif
    endwhile
    return [related_args, remaining_args]
endfunction

function! PrintFunctionField(field_type, field_name, arguments)
    let new_field_type = toupper(a:field_type[0]) . a:field_type[1:]
    execute "normal! O" . a:field_name . " = " . g:MigrateOdooFieldsModule . "." . new_field_type . "(compute='_compute_" . a:field_name . "', " . a:arguments . ")\<esc>"
endfunction

function! PrintNewField(field_type, field_name, arguments)
    let new_field_type = toupper(a:field_type[0]) . a:field_type[1:]
    execute "normal! O" . a:field_name . " = " . g:MigrateOdooFieldsModule . "." . new_field_type . "(" . a:arguments . ")\<esc>"
endfunction
