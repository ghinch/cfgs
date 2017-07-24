#!/bin/bash

# Install Homebrew
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Tapping bundle and casks"
brew tap Homebrew/bundle
brew tap caskroom/cask
brew tap caskroom/versions

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

echo "Installing dependencies from Brewfile"
brew bundle --file=Brewfile

# Activate Sound on menubar

# Set Computer Name
printf "Choose a name for this computer -> "
read COMPUTER_NAME
echo "Setting computer/host name to $COMPUTER_NAME"
sudo scutil --set ComputerName $COMPUTER_NAME
sudo scutil --set HostName $COMPUTER_NAME
sudo scutil --set LocalHostName $COMPUTER_NAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME

# Save to disk (not to iCloud) by default
echo "Save to iCloud by default = false"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
echo "Quit printer app when finished = true"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Finder: show all filename extensions
echo "Show filename extensions = true"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
echo "Show status bar = true"
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
echo "Show path bar = true"
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
echo "Keep folders on top = true"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
echo "Search current folder by default = true"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
echo "Avoid creating .DS_Store files on network/USB drives = true"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
echo "Default to column view in finder"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Automatically hide and show the Dock
echo "Auto-hide dock = true"
defaults write com.apple.dock autohide -bool true
Killall Dock

# Set Safari’s home page to `about:blank` for faster loading
echo "Safari homepage about:blank = true"
defaults write com.apple.Safari HomePage -string "about:blank"

# Warn about fraudulent websites
echo "Warn about fraudulent websites = true"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Only use UTF-8 in Terminal.app
echo "Use UTF-8 in terminal = true"
defaults write com.apple.terminal StringEncodings -array 4

# Disable (Integer = lock delay in seconds)
echo "10 second password delay when screensaver starts"
defaults write com.apple.screensaver askForPasswordDelay -int 10

# Enable AirDrop
echo "Enable AirDrop"
defaults write com.apple.NetworkBrowser DisableAirDrop -bool NO

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

# Set up Python
echo "Installing pip"
easy_install --user pip
echo "installing virtualenvwrapper"
pip install --user virtualenvwrapper
mkdir -p $HOME/.virtualenvs
mkdir -p $HOME/Code

echo "Symlinking virtualenv..."
PYVENV="/usr/local/bin/virtualenv"
if [ -f "$PYVENV" ]
then
    echo "Already symlinked"
else
    ln -s /Users/$USER/Library/Python/2.7/bin/virtualenv $VENVWRAP
fi

echo "Symlinking virtualenvwrapper.sh..."
VENVWRAP="/usr/local/bin/virtualenvwrapper.sh"
if [ -f "$VENVWRAP" ]
then
    echo "Already symlinked"
else
    ln -s /Users/$USER/Library/Python/2.7/bin/virtualenvwrapper.sh $VENVWRAP
fi

echo "Symlinking virtualenvwrapper_lazy.sh..."
VENVWRAP_LAZY="/usr/local/bin/virtualenvwrapper_lazy.sh"
if [ -f "$VENVWRAP_LAZY" ]
then
    echo "Already symlinked"
else
    ln -s /Users/$USER/Library/Python/2.7/bin/virtualenvwrapper_lazy.sh $VENVWRAP_LAZY
fi

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
source /usr/local/bin/virtualenvwrapper.sh

# Configure git
printf "Enter full name for git -> "
read GIT_FULLNAME
git config --global user.name "$GIT_FULLNAME"
printf "Enter email for git -> "
read GIT_EMAIL
git config --global user.email "$GIT_EMAIL"
git config --global core.editor vim

echo "Security: https://objective-see.com/products.html"
