if status is-interactive
    bind -M insert \cf forward-word
    bind -M insert \cr end-of-line

    starship init fish | source
end
