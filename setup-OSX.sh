#!/bin/sh

# Errors out
set -e

function usage {
  
  echo "Usage : $0 [ --help ]"
}

[ "$1" = "-h" ] || [ "$1" = "--help" ] || [ $# -gt 1 ] && { usage && exit 1; }

# Get correct paths
ORIG_PATH=`pwd`
cd `dirname $0`
SCRIPT_PATH=`pwd`
cd $ORIG_PATH

echo "-----------------------------------------------------------------"
echo ""
echo "Welcome to the OSX installation and configuration script !"
echo ""
echo " You will be guide to configure your OSX system (10.10 Yosemite)"
echo ""
echo "-----------------------------------------------------------------"
echo ""

###############################################################################

echo ""
echo "You should update your system now !"
echo "Install also Xcode, paid apps, and your App store apps."

sleep 2 &&

open -a "App Store"

echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

###############################################################################
# General UI/UX
###############################################################################
 
echo ""
echo "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "What would you like it to be?"
  read COMPUTER_NAME
  sudo scutil --set ComputerName $COMPUTER_NAME
  sudo scutil --set HostName $COMPUTER_NAME
  sudo scutil --set LocalHostName $COMPUTER_NAME
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
fi

###############################################################################
# Shell env and tools
###############################################################################

echo "Installing Brew package manager..."
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
  
echo "Installing brew packages..."

apps=(
  htop
  git
  iftop
  fortune
  wakeonlan
  vim
  zsh
  git
  cmake
  nmap
  ffmpeg
)

brew install ${apps[@]}

echo "Customizing your shell with better bash and vim"
cp $(SCRIPT_PATH)/shell/bash_profile ~/.bash_profile
cp $(SCRIPT_PATH)/shell/vimrc ~/.vimrc

echo "Installing zsh"

brew install zsh
# first copy of a simple zshrc
cp shell/zshrc ~/.zshrc
sudo sh -c 'echo $(which zsh) >> /etc/shells'
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
    chsh -s `which zsh`
fi

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

###############################################################################

#TODO -> copy oh my zsh correct template to zshrc
echo "Installing quicklook additional features"

# List from here : https://github.com/sindresorhus/quick-look-plugins

apps=(
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  qlprettypatch
  quicklook-csv
  qlimagesize
)

brew cask install ${apps[@]}

###############################################################################

echo "Installing softwares"

brew install caskroom/cask/brew-cask

apps=(
  a-better-finder-rename
  unrarx
  #alfred # Alfred3 seems to be only on the web
  clementine
  dropbox
  google-chrome
  firefox
  #slack # Have it from app store
  iterm2
  sublime-text
  vlc
  skype
  transmission
  webtorrent
  sourcetree
  #menumeters # Not working with macOS Sierra, try here : https://github.com/yujitach/MenuMeters
  java
  xquartz
  arduino
  calibre
  sketchup
  processing
  filezilla
  applepi-baker
  meshlab
  cuda
  fritzing
  libreoffice
  libreoffice-language-pack
  evernote
  telegram
  resolume-arena
  processing
  syphon-virtual-screen
)

# Install apps to /Applications
echo "Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Manually installing softwares..."

open -a firefox http://millumin.com/
open -a firefox https://osculator.net/
# Download osctestapp from here
open -a firefox https://github.com/mrRay/vvopensource
open -a firefox http://imimot.com/vezer/
open -a firefox https://github.com/Lyptik/go-2-iTerm/releases

###############################################################################

brew cleanup
brew cask cleanup

echo "Check what the doctor says and fix it..."
echo ""
brew doctor
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

###############################################################################

echo "Configuring git"
$(SCRIPT_PATH)/shell/setupGit.sh

###############################################################################

echo "Installing Xcode theme"

mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp $(SCRIPT_PATH)/submodules/

###############################################################################

echo "Done."
