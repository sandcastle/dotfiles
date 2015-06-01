# change default shell to zsh
chsh -s /bin/zsh

# set work dir
dir="$HOME/dev/.files"

# remove old version
rm -rf $dir

# create clone folder
mkdir -p $dir

# clone repo
git clone --recursive git://github.com/sandcastle/dotfiles.git $dir

# symlink files
cd $dir
sudo sh "symlink-dotfiles.sh"
