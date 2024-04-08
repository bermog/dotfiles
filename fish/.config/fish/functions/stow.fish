# Prevent buggy warning when unstowing a package (https://github.com/aspiers/stow/issues/65#issuecomment-1835777867)
function stow
    bash -c "stow $argv 2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)"
end
