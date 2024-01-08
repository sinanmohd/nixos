{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [ tmux ];

    etc."tmux.conf".text = ''
      # base
      set-option -g prefix C-a
      unbind-key C-b
      bind-key C-a send-prefix
      setw -g pane-base-index 1
      set -g history-limit 10000

      # vim
      set -g mode-keys vi
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection
      bind -r C-w last-window

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # not eye candy
      set -g status-style "bg=default fg=7"
      set -g status-left ""
      set -g status-right "#{session_name}"
    '';
  };
}
