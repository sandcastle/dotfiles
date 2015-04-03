# change default shell to zsh
chsh -s /bin/zsh

# create clone folder
dir="$HOME/dev/.files"
mkdir -p $dir
cd $dir

# clone repo
git clone --recursive git://github.com/sandcastle/dotfiles.git
cd dotfiles

# symlink files
sudo sh symlink-dotfiles.sh
