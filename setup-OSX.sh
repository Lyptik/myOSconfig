#!/bin/sh

# TODO :

# Use mackup to save and sync all your settings
# Use this for automation : https://gist.github.com/brandonb927/3195465

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
  homebrew/x11/meld
  nmap
)

brew install ${apps[@]}

# Use htop without sudo
sudo chown root:wheel /usr/local/bin/htop
sudo chmod u+s /usr/local/bin/htop

# TODO : do it for iftop
#sudo chown root:wheel /usr/local/bin/iftop
#sudo chmod u+s /usr/local/bin/iftop

echo "Customizing your shell with better bash and vim"
cp shell/bash_profile ~/.bash_profile
cp shell/vimrc ~/.vimrc

echo "Installing zsh and oh-my-zsh..."
brew install zsh
# first copy of a simple zshrc
cp shell/zshrc ~/.zshrc
# TODO : TOTEST
sudo sh -c 'echo $(which zsh) >> /etc/shells'
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
    chsh -s `which zsh`
fi

git clone https://github.com/Lyptik/oh-my-zsh.git ~/.oh-my-zsh

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! TODO otherwise zsh not working with ohmyzsh

#TODO -> copy oh my zsh correct template to zshrc

###############################################################################

brew install caskroom/cask/brew-cask

apps=(
  unrarx
  #alfred
  dropbox
  google-chrome
  firefox
  #screenflick
  #slack
  #transmit
  appcleaner
  firefox
  #hazel
  #seil
  #spotify
  #vagrant
  #arq
  iterm2
  sublime-text3
  #virtualbox
  #atom
  #flux
  #mailbox
  #sketch
  #tower
  vlc
  #cloudup
  #nvalt
  skype
  transmission
  #flashlight
  sourcetree
  menumeters
  java
  flash
  xquartz
  arduino
  calibre
  sketchup
  processing
  filezilla
  sketchupviewer
  applepi-baker
  meshlab
  cuda
  fritzing
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

###############################################################################

# List from here : https://github.com/sindresorhus/quick-look-plugins

apps=(
	qlcolorcode
	qlstephen
	qlmarkdown
	quicklook-json
	qlprettypatch
	quicklook-csv
	#betterzipql # Spotted this dude causing 100% CPU
	qlimagesize
	#webpquicklook # wrong link at time of writing
	#suspicious-package # wrong link at time of writing
)

echo "Installing a lot of quicklook features"

brew cask install ${apps[@]}        

###############################################################################

brew doctor

echo "Check what the doctor says and fix it..."
echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

###############################################################################

brew cleanup
brew cask cleanup

###############################################################################

echo "Configuring git"
# Git does setup meld as main diff, so meld should be already installed
./shell/setupGit.sh

###############################################################################

echo "Customize preferences / Finder and the term youre using..."

echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

###############################################################################

echo "Making a second makeup to your shell experience :)"
echo "Install go-2-iTerm in your Applications and use it later with spotlight"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer

open -a firefox https://github.com/Lyptik/go-2-iTerm/releases

###############################################################################

# TODO

sublime preferences (copy settings file)
xcode monokai (fetch submodule and install it)

# Download apps manually or copy from old install

a better file rename
eclipse
millumin
arena
modulo
nmu
osculator
osctestapp

// Own tools
augmenta
canon2Syphon
z vector
d light
pacmanize
are you my friend
insult your friend

