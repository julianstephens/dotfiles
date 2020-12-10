" Replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »

" Open most folds
setlocal foldlevel=6

" Default formatting
let g:pencil#mode_indicators = {'hard': 'H', 'auto': 'A', 'soft': 'S', 'off': '',}
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#cursorwrap = 0 
