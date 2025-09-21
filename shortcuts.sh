#!/bin/bash
# Rebind Super+1..9 to always open a new window in GNOME

for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings switch-to-application-$i []
  gsettings set org.gnome.shell.keybindings open-new-window-application-$i "['<Super>$i']"
done
echo "Keybindings for super+1..9 now reset"


# Makes ctrl + backspace the norm - cuz who acc uses ctrl + w:
# Detect what Ctrl+Backspace sends
keycode=$(echo | cat -v | sed -n 's/^\^//p')
# Make sure ~/.inputrc exists
touch ~/.inputrc
# Add bindings if not already present
if ! grep -q 'backward-kill-word' ~/.inputrc; then
  echo 'Adding Ctrl+Backspace mapping to ~/.inputrc...'

  # Default case (Ctrl+Backspace usually sends ^H or ^?)
  echo '"\C-h": backward-kill-word' >> ~/.inputrc
  echo '"\C-?": backward-kill-word' >> ~/.inputrc
fi


# changing settings for nvim too...
NVIM_KEYMAP_FILE="$HOME/.config/nvim/lua/theprimeagen/remap.lua"

# Add mapping if not already present
if ! grep -q 'CtrlBackspace' "$NVIM_KEYMAP_FILE" 2>/dev/null; then
  cat >> "$NVIM_KEYMAP_FILE" <<'EOF'

-- Ctrl+Backspace deletes previous word in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-h>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-?>", "<C-w>", { noremap = true })

EOF
fi

