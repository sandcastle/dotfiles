# Inspiration:
# -----------------
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# https://github.com/holman/dotfiles/tree/master/osx


dev="$HOME/Developer"

# Main
# ====

# Show battery life percentage.
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1


# Screen
# ======

# Add font smoothing
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the downlaods.
defaults write com.apple.screencapture location "$HOME/Downloads/"


# Inputs
# ======

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write com.apple.AppleMultitouchTrackpad Clicking 1

# Use scroll gesture with the Ctrl (^) modifier key to zoom
sudo defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true


# SSD-specific tweaks
# ======

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine snapshots
sudo tmutil disable

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
# Create a zero-byte file instead … and make sure it can’t be rewritten
sudo rm /Private/var/vm/sleepimage
sudo touch /Private/var/vm/sleepimage
sudo chflags uchg /Private/var/vm/sleepimage

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0


# Finder
# ======

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all windows by default, other modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 0

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true


# Desktop
# ========

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


# Dock
# ========

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Make dock show instantly when hidden
defaults write com.apple.dock autohide-time-modifier -int 0

# Show which apps are hidden
defaults write com.apple.dock showhidden -bool TRUE

# Move the dock to the left
defaults write com.apple.dock orientation -string "right"

# Move the dock to the left
defaults write com.apple.dock autohide -bool TRUE

# Magnify on hover
defaults write com.apple.dock magnification -bool TRUE

# Icon size
defaults write com.apple.dock tilesize -int 128

# Magnification size
defaults write com.apple.dock largesize -int 64


# Terminal
# ========

# Use a modified version of the Pro theme by default in Terminal.app
open "$dev/dotfiles/terminal/sandcastle.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal 'Default Window Settings' -string 'sandcastle'
defaults write com.apple.terminal 'Startup Window Settings' -string 'sandcastle'

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4


# Fin
# ========

# reset finder
killall Finder
killall Dock
