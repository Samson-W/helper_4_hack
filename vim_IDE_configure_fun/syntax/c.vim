"========================================================
" Highlight All Function
"========================================================
syn matchcFunction "/<[a-zA-Z_][a-zA-Z_0-9]*/>[^()]*)("me=e-2
syn matchcFunction "/<[a-zA-Z_][a-zA-Z_0-9]*/>/s*("me=e-1
hi cFunctiongui=NONE guifg=#B5A1FF

"========================================================
" Highlight All Math Operator
"========================================================
" C math operators
syn matchcMathOperatordisplay "[-+/*/%=]"
" C pointer operators
syn matchcPointerOperatordisplay "->/|/."
" C logical   operators - boolean results
syn matchcLogicalOperatordisplay "[!<>]=/="
syn match cLogicalOperatordisplay "=="
" C bit operators
syn matchcBinaryOperatordisplay "/(&/||/|/^/|<</|>>/)=/="
syn matchcBinaryOperatordisplay "/~"
syn matchcBinaryOperatorError display "/~="
" More C logical operators - highlight in preference to binary
syn matchcLogicalOperatordisplay "&&/|||"
syn match cLogicalOperatorError display "/(&&/|||/)="

" Math Operator
hi cMathOperatorguifg=#3EFFE2
hi cPointerOperatorguifg=#3EFFE2
hi cLogicalOperatorguifg=#3EFFE2
hi cBinaryOperatorguifg=#3EFFE2
hi cBinaryOperatorErrorguifg=#3EFFE2
hi cLogicalOperatorguifg=#3EFFE2
hi cLogicalOperatorErrorguifg=#3EFFE2

"========================================================
" My Own DataType
"========================================================
syn keyword cType       My_Type_1 My_Type_2 My_Type_3


