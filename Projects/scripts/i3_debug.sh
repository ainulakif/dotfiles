
#!/bin/bash
echo "$(date): Starting WezTerm with fastfetch" >> /tmp/i3_debug.log

# Execute the command and log its output/errors:
i3-msg 'workspace 1; exec /usr/bin/wezterm start -- zsh -c "fastfetch; exec zsh"' >> /tmp/i3_debug.log 2>&1

echo "$(date): Command executed" >> /tmp/i3_debug.log
