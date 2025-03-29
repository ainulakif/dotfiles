
#!/bin/bash

# Switch to workspace 1 and launch WezTerm with the fastfetch command.
i3-msg 'workspace 1; exec /usr/bin/wezterm start -- zsh -c "fastfetch; exec zsh"'
