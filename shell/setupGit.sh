# Git setup

# configure the user which will be used by git
# Of course you should use your name
git config --global user.name "David-Alexandre Chanel"

# Same for the email address
git config --global user.email "david.alexandre.chanel.ext@gmail.com" 

# set default so that all changes are always pushed to the repository
git config --global push.default "matching"

# set default so that you avoid unnecessary commits
#git config --global branch.autosetuprebase always 

git config --global color.status auto
git config --global color.branch auto
git config --global core.editor vim
mkdir -p ~/.git

#case `uname` in

#  Darwin)
#        MELD_PATH=/usr/local/Cellar/meld/1.8.6/bin/meld
#	;;

#  Linux)
#        MELD_PATH=/usr/bin/local/meld
#        ;;
#esac

# Configure Meld as diff tool
# Meld can be installed with this : brew install homebrew/x11/meld
# Meld has XQuartz dependency : 
#echo "#!/usr/bin/python\nimport sys\nimport os\nos.system('$MELD_PATH "%s" "%s"' % (sys.argv[2], sys.argv[5]))" > ~/.git/git-diff.py
#git config --global diff.external ~/.git/git-diff.py
#git config --global merge.tool meld

# aliases
git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.df diff
git config --global alias.lg log -p

git config --list
