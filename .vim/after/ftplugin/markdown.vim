" after/ftplugin/markdown.vim
" Read Markdown as prose, not as code.

" Drop the loud invisible-char glyphs (¬ · ▸) inside prose buffers.
setlocal nolist

" Soft-wrap at word boundaries instead of mid-word; keep indentation on wrap.
setlocal wrap linebreak breakindent
setlocal textwidth=0

" Conceal the **/*/`/[] markup so formatted text reads cleanly, but reveal the
" markers again on whatever line the cursor is on for easy editing.
setlocal conceallevel=2
setlocal concealcursor=

" Move by screen line over wrapped paragraphs (only remap when unwrapped 'j'/'k'
" haven't been customised, and keep counts like 5j behaving normally).
nnoremap <buffer> <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <buffer> <silent> <expr> k v:count ? 'k' : 'gk'
