# dotfiles

My personal configuration files and dotfiles managed with [rotz](https://github.com/volllly/rotz).

## Prerequisites

Install rotz, the dotfile manager:

```bash
# macOS
brew install volllly/tap/rotz
```

## Installation

```bash
rotz clone https://github.com/marcelbruckner/.dotfiles.git 
```

## Usage

### Link dotfiles (without installing apps)
```bash
# All dotfiles
rotz link

# Specific dotfile
rotz link zsh
```
This will:
- Create symbolic links to the appropriate locations

### Install all dotfiles and dependencies:
```bash
# All dotfiles
rotz install

# Specific dotfile
rotz install zsh

# Install apps defined in dot.yaml files
rotz install --only-install
```

This will:
- Install required applications (via Homebrew on macOS)
- Create symbolic links to the appropriate locations

### Check current status
```bash
rotz status
```

### Unlink dotfiles
```bash
rotz unlink
```

## Adding New Dotfiles

1. Create a new directory for your application
2. Add a `dot.yaml` file to configure links and installs
3. Run `rotz install` to apply changes

For more information, see the [rotz documentation](https://github.com/volllly/rotz).
