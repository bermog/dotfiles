function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold brblack
      echo 'N'
    case insert
    case replace_one
      set_color --bold yellow
      echo 'R'
    case visual
      set_color --bold brmagenta
      echo 'V'
    case '*'
      set_color --bold red
      echo '?'
  end
  if [ $fish_bind_mode != insert ]
    set_color normal
    echo ' - '
  end
end
