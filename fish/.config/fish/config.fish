# PATH
# One-time per machine: if an old universal fish_user_paths exists (pre-repo era),
# clear it once with:  set -eU fish_user_paths
# --global keeps fish_user_paths out of the gitignored fish_variables file.
fish_add_path --global \
    ~/.local/share/pnpm/bin \
    ~/.cargo/bin \
    ~/go/bin \
    ~/bin \
    ~/.local/bin

if status is-interactive
    # Vi mode (replaces the old conf.d/fish_frozen_key_bindings.fish)
    set -g fish_key_bindings fish_vi_key_bindings

    bind -M insert \cf forward-word
    bind -M insert \ce end-of-line

    # Init, skipped silently if not installed on this machine
    command -q starship; and starship init fish | source
    command -q zoxide; and zoxide init fish | source
end
