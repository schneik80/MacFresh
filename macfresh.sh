#!/bin/zsh
echo "=== Starting setup ==="

#Install Xcode command line tools
echo "=== Installing Xcode command line tools ==="
xcode-select —-install

read -p "Press any key after Xcode is complete"
echo "=== Xcode complete ==="

#Check for Homebrew to be present, install if it's missing
echo "=== Check for brew ==="
if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating Homebrew"
    brew update
    brew upgrade
fi
echo "=== brew complete ==="

#Install Zsh & Oh My Zsh
echo "=== Installing Oh My ZSH ==="
curl -L http://install.ohmyz.sh | shsudo
echo "=== Zsh Complete ==="

#Install Development apps
DevAPPS=(
    git
    gh
    git-flow
    git-extras
    grip
    markdown-service-tools
    glow
    visual-studio-code
    python3
    pyenv
    iterm2
    wget
    node
    npm
    ctop
    duti
)

echo "=== Installing DEV apps ==="
brew install ${DevAPPS[@]}

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#Configure Git
echo "=== Configuring Git ==="
git config --global user.name "Kevin Schneider"
git config --global user.email schneik80@gmail.com
git config --global help.autocorrect 1
#Use a sensible editor for git commit messages
git config --global core.editor "nano"
#Create the source folder
mkdir ~/Source
echo "=== Git complete ==="

#Install Standard apps
MyAPPS=(
    mas
    cask
    google-chrome
    dropbox
    slack
    zoom
    microsoft-office
    drawio
    transmission
    vlc
    discord
    barrier
    graphviz
    pandoc
    lastpass-cli
    speedtest-cli
    wifi-password
    btop
    nmap
    byobu
    trash
    tree
    ncdu
    lnav
    dozer
    neofetch
)

echo "=== Installing general apps ==="
brew install ${MyAPPS[@]}

alias top="btop"

# Install Mac App Store apps
#   1289583905  Pixlemator pro
#   1563698880  Mirror Magnet
#   1362171212  Caffeinated - Anti Sleep App
#   858446756  World Clock Pro
#   639764244  Xee³: Image Viewer and Browser
#   1225570693  Ulysses | Writing App
#   457622435  Yoink - Improved Drag and Drop
#   1130783329  Archiver 3
#   921553264  Screenium 3
#   412529613  Cinch
#   404705039  Graphic
#   639386679  Vector 3 - Record & Edit Audio 

MacAPPS=(
    1289583905
    1563698880
    1362171212
    858446756
    639764244
    1225570693
    457622435
    1130783329
    921553264
    412529613
    404705039
    639386679
)
echo "=== Installing MAC App Store apps ===."
mas install ${MacAPPS[@]}

echo "=== Cleaning up and setting default system settings ==="
brew cleanup

echo "=== set MAC OS prefrences ==="
# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Expanding the save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enabling subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Showing icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle Clmv

# Avoiding the creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Setting Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Preventing Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable the sudden motion sensor as its not useful for SSDs
sudo pmset -a sms 0

# Set Outlook to be default mail client
# pip install pyobjc-framework-CoreServices
# python3
# from CoreServices import LSSetDefaultHandlerForURLScheme
# LSSetDefaultHandlerForURLScheme("mailto", "com.microsoft.Outlook")
# exit()

# set vscode for markdown an python
duti -s com.microsoft.VSCode .md all
duti -s com.microsoft.VSCode .py all

echo "=== Setup completed! ==="

read -p "Press any key to continue..."

# Neofetch
neofetch
