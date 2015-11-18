syntax on           " color syntax
set exrc
set secure

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set softtabstop=4
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
                    
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

set mouse=a         " Enable the use of the mouse.
set number          " Show line numbers.

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

nnoremap <F7> :NERDTreeToggle<CR>
nnoremap <C-S-D> :set rightleft<CR>
nnoremap <C-S-A> :set rightleft&<CR>
"set cindent
"inoremap {<CR> {<CR>}<up><end><CR><Tab>