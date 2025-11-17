#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./init-git-ssh.sh               # uses default email
#   ./init-git-ssh.sh you@email.com # uses your custom email

DEFAULT_EMAIL="jwrigh26@gmail.com"
EMAIL="${1:-$DEFAULT_EMAIL}"

SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/id_ed25519"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

echo "Using email: $EMAIL"
echo "SSH directory: $SSH_DIR"
echo

# -----------------------------
# Generate key if it doesn't exist
# -----------------------------
if [[ -f "$KEY_PATH" ]]; then
  echo "SSH key already exists at: $KEY_PATH"
else
  echo "No SSH key found, generating a new ed25519 key..."
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH"
  echo "New key created at: $KEY_PATH"
fi

# -----------------------------
# Start ssh-agent (for this shell)
# -----------------------------
echo
echo "Starting ssh-agent and adding the key..."

# Start a new agent for this shell if needed
if [[ -z "${SSH_AUTH_SOCK:-}" ]]; then
  eval "$(ssh-agent -s)" >/dev/null
fi

ssh-add "$KEY_PATH"

# -----------------------------
# Show the public key
# -----------------------------
echo
echo "Your public key (add this to GitHub/GitLab/etc.):"
echo "-------------------------------------------------"
cat "${KEY_PATH}.pub"
echo "-------------------------------------------------"
echo
echo "Next steps:"
echo "  1. Copy the text above."
echo "  2. Go to your Git host (e.g., GitHub → Settings → SSH and GPG keys → New SSH key)."
echo "  3. Paste and save."
echo
echo "You can test with:"
echo "  ssh -T git@github.com"
echo

