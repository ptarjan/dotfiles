" The 4 following lines prevent this script from being loaded several times per buffer.
" They also prevent the load of different indent scripts for PHP at the same time.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal autoindent
setlocal cindent
setlocal cinwords=if,else,elseif,do,while,foreach,for,case,default,function,class,interface,abstract,private,public,protected,final
setlocal cinkeys=0{,0},0),!^F,o,O,e
setlocal cino=(1s

setlocal nosmartindent " don't use smart indent option
