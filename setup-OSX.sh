#!/bin/sh

# TODO :

# Use mackup to save and sync all your settings
# Use this for automation : https://gist.github.com/brandonb927/3195465
# Use cask for more application installed automatically

# Template script explanation

# TODO : Every software can use cask as a software manager good idea ?

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

echo "Time to get Firefox..."

echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

open -a safari https://www.mozilla.org/fr/firefox/new/

echo "Update your system now !"

echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

open -a "App Store"

echo "Customize preferences / Finder and the term youre using..."

echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

echo "Customizing your shell with better bash and vim"
cp shell/bash_profile ~/.bash_profile
cp shell/vimrc ~/.vimrc

echo "Changing hostname with your computer name put in preferences/sharing"
sudo hostname -s `scutil --get ComputerName`

echo "Now Installing a real Term !"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

brew cask install iterm2

echo "Installing Brew package manager..."
echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

# Install home brew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew doctor

echo "Check what the doctor says and fix it..."
echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

echo "Installing shell tools"

brew install htop git iftop fortune wakeonlan

# Use htop without sudo
sudo chown root:wheel /usr/local/bin/htop
sudo chmod u+s /usr/local/bin/htop

# TODO : do it for iftop
#sudo chown root:wheel /usr/local/bin/iftop
#sudo chmod u+s /usr/local/bin/iftop

echo "If you are using dropbox for your data, now is the time to check it up !"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer
[ $answer != "y" ] && { echo "Exiting..."; exit; }

open -a firefox www.dropbox.com

echo "Added a lot of quicklook features"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer

# From here : https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

echo "Enhancing Spotlight experience with flashlight, don't forget to install cool plugins !"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer

brew cask install flashlight

echo "Making a second makeup to your shell experience :)"
echo "Install go-2-iTerm in your Applications and use it later with spotlight"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer

open -a firefox https://github.com/Lyptik/go-2-iTerm/releases

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

echo "Configuring and installing dev tools : git"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer

brew install sourcetree menumeters
brew install git cmake
brew cask install xquartz
brew install meld
# Git does setup meld as main diff, so meld should be already installed
./shell/setupGit.sh

echo "Configuring dev tools"
echo ""
echo "y to continue... (y/n)"
echo ""
read answer

brew cask install java flash

# TODO

sublime preferences
xcode monokai

brew cleanup
brew cask cleanup

brew cask install --appdir="/Applications" iterm2 vlc skype arduino calibre sketchup google-chrome sublime-text3 

==

a better file rename
apple bi baker
arduino
calibre

filezilla 
eclipse
sketchup
meshlab
millumin
arena
modulo
nmu

// Own tools
augmenta
canon2Syphon
z vector
d light
