# change default shell to zsh
chsh -s /bin/zsh

# set work dir
DOT_FILES="$HOME/dev/.files"

# remove old version
rm -rf $DOT_FILES

# create clone folder
mkdir -p $DOT_FILES

# clone repo
git clone --recursive git://github.com/sandcastle/dotfiles.git $DOT_FILES

# symlink files
cd $DOT_FILES
sudo sh "install-symlink.sh"
