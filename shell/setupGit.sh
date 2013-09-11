# Git setup

# configure the user which will be used by git
# Of course you should use your name
git config --global user.name "David Chanel"

# Same for the email address
git config --global user.email "david.alexandre.chanel.ext@gmail.com" 

# set default so that all changes are always pushed to the repository
git config --global push.default "matching"

# set default so that you avoid unnecessary commits
#git config --global branch.autosetuprebase always 

git config --global color.status auto
git config --global color.branch auto
git config --global core.editor vim 

# aliases

git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.df diff
git config --global alias.lg log -p

git config --list

## Global .gitignore

# Create a ~/.gitignore in your user directory
cd ~ &&

# if .gitignore already exists erase it
[ -f .gitignore ] && rm .gitignore

touch .gitignore &&

# Exclude bin and .metadata directories
#echo "bin" >> .gitignore
echo "build" >> .gitignore &&
echo ".metadata" >> .gitignore &&
echo ".svn" >> .gitignore &&
echo ".DS_Store" >> .gitignore &&
echo "*~" >> .gitignore &&
echo "*.user" >> .gitignore &&
echo "*.o" >> .gitignore &&
echo "*.app" >> .gitignore &&
echo "*.pyc" >> .gitignore &&
echo "*.csproj" >> .gitignore &&
echo "*.pidb" >> .gitignore &&
echo "*.userprefs" >> .gitignore &&

# Configure Git to use this file
# as global .gitignore
git config --global core.excludesfile ~/.gitignore
