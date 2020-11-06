provide-module sleuth %{
  define-command sleuth -docstring 'Heuristically set buffer options' %{
    try %{
      evaluate-commands -draft %{
        # Search the first indent level
        execute-keys 'gg' '/' '^\h+' '<ret>'

        # Tab vs. Space
        # https://youtu.be/V7PLxL8jIl8
        try %{
          execute-keys '<a-k>' '\t' '<ret>'
          set-option buffer indentwidth 0
        } catch %{
          set-option buffer indentwidth %val{selection_length}
        }
      }
    }
  }

  define-command sleuth-enable -docstring 'Enable sleuth' %{
    # Run sleuth when opening and saving files.
    hook -group sleuth global BufOpenFile .* %{
      sleuth
    }

    hook -group sleuth global BufWritePost .* %{
      sleuth
    }
  }

  define-command sleuth-disable -docstring 'Disable sleuth' %{
    remove-hooks global sleuth
  }
}
