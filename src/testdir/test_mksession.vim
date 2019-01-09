" Test for :mksession, :mkview and :loadview in latin1 encoding

set encoding=latin1
scriptencoding latin1

if !has('multi_byte') || !has('mksession')
  finish
endif

source shared.vim

func Test_mksession()
  tabnew
  let wrap_save = &wrap
  set sessionoptions=buffers splitbelow fileencoding=latin1
  call setline(1, [
    \   'start:',
    \   'no multibyte chAracter',
    \   '	one leaDing tab',
    \   '    four leadinG spaces',
    \   'two		consecutive tabs',
    \   'two	tabs	in one line',
    \   'one � multibyteCharacter',
    \   'a� �  two multiByte characters',
    \   'A���  three mulTibyte characters',
    \   'short line',
    \ ])
  let tmpfile = 'Xtemp'
  exec 'w! ' . tmpfile
  /^start:
  set wrap
  vsplit
  norm! j16|
  split
  norm! j16|
  split
  norm! j16|
  split
  norm! j8|
  split
  norm! j8|
  split
  norm! j16|
  split
  norm! j16|
  split
  norm! j16|
  split
  norm! j$
  wincmd l

  set nowrap
  /^start:
  norm! j16|3zl
  split
  norm! j016|3zl
  split
  norm! j016|3zl
  split
  norm! j08|3zl
  split
  norm! j08|3zl
  split
  norm! j016|3zl
  split
  norm! j016|3zl
  split
  norm! j016|3zl
  split
  call wincol()
  mksession! Xtest_mks.out
  let li = filter(readfile('Xtest_mks.out'), 'v:val =~# "\\(^ *normal! [0$]\\|^ *exe ''normal!\\)"')
  let expected = [
    \   'normal! 016|',
    \   'normal! 016|',
    \   'normal! 016|',
    \   'normal! 08|',
    \   'normal! 08|',
    \   'normal! 016|',
    \   'normal! 016|',
    \   'normal! 016|',
    \   'normal! $',
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|",
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|",
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|",
    \   "  exe 'normal! ' . s:c . '|zs' . 8 . '|'",
    \   "  normal! 08|",
    \   "  exe 'normal! ' . s:c . '|zs' . 8 . '|'",
    \   "  normal! 08|",
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|",
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|",
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|",
    \   "  exe 'normal! ' . s:c . '|zs' . 16 . '|'",
    \   "  normal! 016|"
    \ ]
  call assert_equal(expected, li)
  tabclose!

  call delete('Xtest_mks.out')
  call delete(tmpfile)
  let &wrap = wrap_save
  set sessionoptions&
endfunc

func Test_mksession_winheight()
  new
  set winheight=10
  set winminheight=2
  mksession! Xtest_mks.out
  source Xtest_mks.out

  call delete('Xtest_mks.out')
endfunc

func Test_mksession_large_winheight()
  set winheight=999
  mksession! Xtest_mks_winheight.out
  set winheight&
  source Xtest_mks_winheight.out
  call delete('Xtest_mks_winheight.out')
endfunc

func Test_mksession_arglist()
  argdel *
  next file1 file2 file3 file4
  mksession! Xtest_mks.out
  source Xtest_mks.out
  call assert_equal(['file1', 'file2', 'file3', 'file4'], argv())

  call delete('Xtest_mks.out')
  argdel *
endfunc

func Test_mksession_one_buffer_two_windows()
  edit Xtest1
  new Xtest2
  split
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let count1 = 0
  let count2 = 0
  let count2buf = 0
  for line in lines
    if line =~ 'edit \f*Xtest1$'
      let count1 += 1
    endif
    if line =~ 'edit \f\{-}Xtest2'
      let count2 += 1
    endif
    if line =~ 'buffer \f\{-}Xtest2'
      let count2buf += 1
    endif
  endfor
  call assert_equal(1, count1, 'Xtest1 count')
  call assert_equal(2, count2, 'Xtest2 count')
  call assert_equal(2, count2buf, 'Xtest2 buffer count')

  close
  bwipe!
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_lcd_multiple_tabs()
  tabnew
  tabnew
  lcd .
  tabfirst
  lcd .
  mksession! Xtest_mks.out
  tabonly
  source Xtest_mks.out
  call assert_true(haslocaldir(), 'Tab 1 localdir')
  tabnext 2
  call assert_true(!haslocaldir(), 'Tab 2 localdir')
  tabnext 3
  call assert_true(haslocaldir(), 'Tab 3 localdir')
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_blank_tabs()
  tabnew
  tabnew
  tabnew
  tabnext 3
  mksession! Xtest_mks.out
  tabnew
  tabnew
  tabnext 2
  source Xtest_mks.out
  call assert_equal(4, tabpagenr('$'), 'session restore should restore number of tabs')
  call assert_equal(3, tabpagenr(), 'session restore should restore the active tab')
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_blank_windows()
  split
  split
  split
  3 wincmd w
  mksession! Xtest_mks.out
  split
  split
  2 wincmd w
  source Xtest_mks.out
  call assert_equal(4, winnr('$'), 'session restore should restore number of windows')
  call assert_equal(3, winnr(), 'session restore should restore the active window')
  call delete('Xtest_mks.out')
endfunc

if has('terminal')

func Test_mksession_terminal_shell()
  terminal
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let term_cmd = ''
  for line in lines
    if line =~ '^terminal'
      let term_cmd = line
    elseif line =~ 'badd.*' . &shell
      call assert_report('unexpected shell line: ' . line)
    endif
  endfor
  call assert_match('terminal ++curwin ++cols=\d\+ ++rows=\d\+\s*$', term_cmd)

  call Stop_shell_in_terminal(bufnr('%'))
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_terminal_no_restore_cmdarg()
  terminal ++norestore
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let term_cmd = ''
  for line in lines
    if line =~ '^terminal'
      call assert_report('session must not restore teminal')
    endif
  endfor

  call Stop_shell_in_terminal(bufnr('%'))
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_terminal_no_restore_funcarg()
  call term_start(&shell, {'norestore': 1})
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let term_cmd = ''
  for line in lines
    if line =~ '^terminal'
      call assert_report('session must not restore teminal')
    endif
  endfor

  call Stop_shell_in_terminal(bufnr('%'))
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_terminal_no_restore_func()
  terminal
  call term_setrestore(bufnr('%'), 'NONE')
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let term_cmd = ''
  for line in lines
    if line =~ '^terminal'
      call assert_report('session must not restore teminal')
    endif
  endfor

  call Stop_shell_in_terminal(bufnr('%'))
  call delete('Xtest_mks.out')
endfunc

func Test_mksession_terminal_no_ssop()
  terminal
  set sessionoptions-=terminal
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let term_cmd = ''
  for line in lines
    if line =~ '^terminal'
      call assert_report('session must not restore teminal')
    endif
  endfor

  call Stop_shell_in_terminal(bufnr('%'))
  call delete('Xtest_mks.out')
  set sessionoptions&
endfunc

func Test_mksession_terminal_restore_other()
  terminal
  call term_setrestore(bufnr('%'), 'other')
  mksession! Xtest_mks.out
  let lines = readfile('Xtest_mks.out')
  let term_cmd = ''
  for line in lines
    if line =~ '^terminal'
      let term_cmd = line
    endif
  endfor
  call assert_match('terminal ++curwin ++cols=\d\+ ++rows=\d\+ other', term_cmd)

  call Stop_shell_in_terminal(bufnr('%'))
  call delete('Xtest_mks.out')
endfunc

endif " has('terminal')

" Test :mkview with a file argument.
func Test_mkview_file()
  " Create a view with line number and a fold.
  help :mkview
  set number
  norm! V}zf0
  let pos = getpos('.')
  let linefoldclosed1 = foldclosed('.')
  mkview! Xview
  set nonumber
  norm! zrj
  " We can close the help window, as mkview with a file name should
  " generate a command to edit the file.
  helpclose

  source Xview
  call assert_equal(1, &number)
  call assert_match('\*:mkview\*$', getline('.'))
  call assert_equal(pos, getpos('.'))
  call assert_equal(linefoldclosed1, foldclosed('.'))

  " Creating a view again with the same file name should fail (file
  " already exists). But with a !, the previous view should be
  " overwritten without error.
  help :loadview
  call assert_fails('mkview Xview', 'E189:')
  call assert_match('\*:loadview\*$', getline('.'))
  mkview! Xview
  call assert_match('\*:loadview\*$', getline('.'))

  call delete('Xview')
  bwipe
endfunc

" Test :mkview and :loadview with a custom 'viewdir'.
func Test_mkview_loadview_with_viewdir()
  set viewdir=Xviewdir

  help :mkview
  set number
  norm! V}zf
  let pos = getpos('.')
  let linefoldclosed1 = foldclosed('.')
  mkview 1
  set nonumber
  norm! zrj

  loadview 1

  " The directory Xviewdir/ should have been created and the view
  " should be stored in that directory.
  call assert_equal('Xviewdir/' .
        \           substitute(
        \             substitute(
        \               expand('%:p'), '/', '=+', 'g'), ':', '=-', 'g') . '=1.vim',
        \           glob('Xviewdir/*'))
  call assert_equal(1, &number)
  call assert_match('\*:mkview\*$', getline('.'))
  call assert_equal(pos, getpos('.'))
  call assert_equal(linefoldclosed1, foldclosed('.'))

  call delete('Xviewdir', 'rf')
  set viewdir&
  helpclose
endfunc

func Test_mkview_no_file_name()
  new
  " :mkview or :mkview {nr} should fail in a unnamed buffer.
  call assert_fails('mkview', 'E32:')
  call assert_fails('mkview 1', 'E32:')

  " :mkview {file} should succeed in a unnamed buffer.
  mkview Xview
  help
  source Xview
  call assert_equal('', bufname('%'))

  call delete('Xview')
  %bwipe
endfunc

" vim: shiftwidth=2 sts=2 expandtab
