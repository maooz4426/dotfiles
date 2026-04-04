{ pkgs, ... }: {
    programs.tmux = {
        enable = true;
        prefix = "C-t";
        keyMode = "vi";
        mouse = true;

        plugins = with pkgs.tmuxPlugins; [
            {
                plugin = power-theme;
                extraConfig = ''
                    set -g @tmux_power_theme 'violet'
                    set-option -g status-fg color15
                    set-option -g status-bg colour57
                '';
            }
        ];

        extraConfig = ''
            # pane border
            set-option -g pane-border-style "fg=colour238"
            set-option -g pane-active-border-style "fg=#9370db"

            # pane splits
            bind ^ split-window -h
            bind - split-window -v

            # select pane (no prefix)
            bind -n C-h select-pane -L
            bind -n C-j select-pane -D
            bind -n C-k select-pane -U
            bind -n C-l select-pane -R

            # resize pane
            bind -r H resize-pane -L 5
            bind -r J resize-pane -D 5
            bind -r K resize-pane -U 5
            bind -r L resize-pane -R 5

            # copy mode
            bind-key v copy-mode
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
            bind-key p run "pbcopy | tmux load-buffer - ; tmux paste-buffer"

            # window style
            set -g window-style 'fg=default,bg=default'
            set -g window-active-style 'fg=default,bg=default'

            # passthrough (for image display etc.)
            set -g allow-passthrough on

            # reload config
            bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
        '';
    };
}
