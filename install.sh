# change default shell to zsh
chsh -s /bin/zsh

# fir
dir="$HOME/dev/.files"

# remove old version
rm -rf /Users/glenn/dev/.files

# create clone folder
mkdir -p $dir

# clone repo
git clone --recursive git://github.com/sandcastle/dotfiles.git $dir

# symlink files
sudo sh "$dir/symlink-dotfiles.sh"
