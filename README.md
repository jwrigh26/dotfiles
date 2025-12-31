# Dotfiles Setup Guide for Fedora 43

This repository contains my personal dotfiles and setup scripts. Below is a step-by-step guide to set up a fresh Fedora 43 installation using these files.

## Prerequisites

- **Fedora 43 installed**: Ensure you have sudo access and internet connectivity.
- **Clone your dotfiles**: On the new machine, run:
  ```bash
  git clone https://github.com/your-username/dotfiles.git ~/dotfiles  # Replace with your actual repo URL
  ```
  If it's not a Git repo, copy the folder manually.
- **Install essential packages**: Fedora 43 uses DNF. Run these to get started:
  ```bash
  sudo dnf update -y
  sudo dnf install -y zsh vim git tmux curl wget util-linux-user  # Core tools
  ```
  - Set Zsh as your default shell: `chsh -s $(which zsh)`
  - Log out and back in for the shell change to take effect.

## Step 1: Set Up Zsh (Shell Configuration)

Your `zshrc.template` and `setup-zsh-form-template.sh` script handle this. The template includes aliases, NVM setup, and workspace paths.

- Run the setup script:
  ```bash
  cd ~/dotfiles
  ./setup-zsh-form-template.sh
  ```
  - This backs up any existing `~/.zshrc` and replaces it with your template.
  - It sources `.shell_common` for aliases (e.g., `gs` for `git status`, `ll` for `ls -alF`).
- Manually symlink `.shell_common` and `.tmux.conf` (if not handled by the script):
  ```bash
  ln -sf ~/dotfiles/.shell_common ~/.shell_common
  ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
  ```
- Open a new terminal or run `source ~/.zshrc` to apply changes. Your prompt will now show Git branch info, and aliases like `cdev` (cd to ~/workspace) will work.

## Step 2: Set Up Git and SSH

Your `gitconfig` and `init-git-ssh.sh` script handle Git config and SSH key generation.

- Run the SSH init script:
  ```bash
  cd ~/dotfiles
  ./init-git-ssh.sh  # Or ./init-git-ssh.sh your-email@example.com to override the default
  ```
  - This generates an Ed25519 SSH key (if none exists), starts ssh-agent, and adds the key.
  - Copy the displayed public key to GitHub/GitLab/etc., for SSH-based Git access.
- Symlink your Git config:
  ```bash
  ln -sf ~/dotfiles/gitconfig ~/.gitconfig
  ```
  - Edit `~/.gitconfig` to replace `NAME_GOES_HERE` and `my_email@gmail.com` with your actual name and email.
- Test Git: `ssh -T git@github.com` (should succeed after adding the key).

## Step 3: Set Up Vim

Your `vimrc` and `vim-cheatsheet.html` handle Vim config and reference.

- Symlink Vim config:
  ```bash
  ln -sf ~/dotfiles/vimrc ~/.vimrc
  ```
- Install Vim plugins (requires Vim-Plug; install it first):
  ```bash
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall  # Opens Vim, installs plugins (FZF, ALE), then quits
  ```
- The `vimrc` sets up fuzzy finding (e.g., `<Space>p` for files), linting (ESLint/Prettier), and your Arctic Darcula theme.
- For reference, open `vim-cheatsheet.html` in a browser for keybindings.

## Step 4: Set Up VS Code

Your `vscode-settings` file contains your VS Code config.

- Install VS Code (if not already):
  ```bash
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  sudo dnf install -y code
  ```
- Symlink settings:
  ```bash
  mkdir -p ~/.config/Code/User
  ln -sf ~/dotfiles/vscode-settings ~/.config/Code/User/settings.json
  ```
- Install extensions mentioned in settings (e.g., Prettier, ESLint, GitLens, Vim, GitHub Copilot). You can do this via VS Code UI or CLI: `code --install-extension esbenp.prettier-vscode` (repeat for others).

## Step 5: Set Up Docker

Your `docker.md`, `docker-commands.md`, and `docker-cheat.sh` provide installation and reference.

- Follow the Docker install guide in `docker.md`:
  ```bash
  sudo dnf install -y docker-cli containerd docker-compose
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
  ```
  - Log out/in for group changes.
  - Test: `docker run --rm hello-world`
- For quick reference, run `./docker-cheat.sh` to print a command cheat sheet.
- Use `docker-commands.md` for detailed flags/examples.

## Step 6: Additional Setup and Testing

- **Workspace directories**: Create your dev folders as referenced in `zshrc.template`:
  ```bash
  mkdir -p ~/workspace/{work,personal,experiments}
  ```
- **NVM (Node.js)**: Install NVM as per `zshrc.template`:
  ```bash
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  source ~/.zshrc  # Then: nvm install node
  ```
- **Test everything**:
  - Zsh: Run `cdev` to jump to workspace.
  - Git: `gs` (alias for `git status`).
  - Vim: Open a file and try `<Space>p` for fuzzy search.
  - Docker: `./docker-cheat.sh` for commands.
- **Backup/Restore**: If you have data, restore from backups. For secrets (e.g., NPM_TOKEN in `zshrc.template`), set them manually.

## Notes

- **Permissions**: Run scripts with `./` and ensure they're executable (`chmod +x script.sh` if needed).
- **Customizations**: Edit files in `~/dotfiles` and re-run symlinks/scripts as needed.
- **Troubleshooting**: If something fails (e.g., SELinux issues with Docker), check `docker.md` notes. For errors, run `get_errors` in VS Code or check logs.
- **Security**: The SSH script generates keys securely; don't share private keys.

This should get your new Fedora 43 machine fully set up with your dotfiles. If you run into issues or need tweaks, check the individual files or open an issue in this repo.