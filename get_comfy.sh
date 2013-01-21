# Before running you must manually install MacPorts and duti

# Much of this is stolen from https://github.com/mathiasbynens/dotfiles/blob/master/.osx?os-x-10.8

########## OTHER APPS I LIKE AND NEED ###########
# duti
# MacPorts
# VLC

# Chrome
# keepassx
# Firefox
# iTerm 2
# steam
# Transmission
# Silverlight
# Dropbox
# Google Voice and Video

# App Store
# =========
# Xcode


HG=hg


[ -z "$NEW_HOSTNAME" ] && echo "Need to set NEW_HOSTNAME" && exit 1;
[ -z "$SSH_KEY_LOC" ] && echo "Need to set SSH_KEY_LOC" && exit 1;


mkdir -p ~/.ssh 
chmod 700 ~/.ssh
echo "###################   Getting SSH keys from specified host."
scp -r $SSH_KEY_LOC ~/

username=`whoami`

# Set default shell to zsh


case `uname -s` in
    'Linux')
        PACKAGES="git wine zsh keychain gnome-do docky hg"
        echo "###################    Installing packages"
        su -c "yum install -y ${PACKAGES}"
        echo "###################    Changing shell"
        su -c "chsh -s /bin/zsh $username"
    ;;  
    'Darwin')

        # Install some stuff for MacPorts that I like
        PORTS_TO_GET="python27 py27-htmldocs python32 python33 python_select py27-numpy py32-numpy py27-scipy py32-scipy py27-matplotlib py27-matplotlib-basemap tmux git-core mercurial"

        # tmux-pasteboard
        # vim-app
        # git-extras
        # GitX
        # Skype

        echo "###################    Installing applications using mac ports"
        sudo /opt/local/bin/port install $PORTS_TO_GET


        # Set the default application for some file types
        duti -s org.videolan.vlc .avi all
        duti -s org.videolan.vlc .mp4 all


        # Setup those defaults!

        # Enable tab in menus
        defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

        # Disable "natural" scrolling
        defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

        # Disable swipe to go back pages
        defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

        # Always show scroll bars
        defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

        ########### Hot corners ###########
        # Top right shows Desktop
        defaults write com.apple.dock wvous-tr-corner -int 4
        defaults write com.apple.dock wvous-tr-modifier -int 0

        # Top left corner starts screen saver
        defaults write com.apple.dock wvous-tl-corner -int 5
        defaults write com.apple.dock wvous-tl-modifier -int 0

        # Bottom right corner does mission control
        defaults write com.apple.dock wvous-br-corner -int 2
        defaults write com.apple.dock wvous-br-modifier -int 0

        # Bottom left corner shows applications
        defaults write com.apple.dock wvous-bl-corner -int 3
        defaults write com.apple.dock wvous-bl-modifier -int 0

        sudo scutil --set ComputerName "$NEW_HOSTNAME"
        sudo scutil --set HostName "$NEW_HOSTNAME"
        sudo scutil --set LocalHostName "$NEW_HOSTNAME"
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$NEW_HOSTNAME"

        # Disable auto-correct
        defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

        # Avoid creating .DS_Store files on network volumes
        defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

        # Finder: show hidden files by default
        defaults write com.apple.finder AppleShowAllFiles -bool true

        # Finder: show all filename extensions
        defaults write NSGlobalDomain AppleShowAllExtensions -bool true

        # Finder: show status bar
        defaults write com.apple.finder ShowStatusBar -bool true

        # Display full POSIX path as Finder window title
        defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

        # When performing a search, search the current folder by default
        defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

        # Disable the warning when changing a file extension
        defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false





        HG=/opt/local/bin/hg
        echo "###################    Changing shell"
        chsh -s /bin/zsh $username

    ;;  
esac



mkdir -p ~/code
cd ~/code
$HG clone ssh://hg@bitbucket.org/zbisch/zconfigs > /dev/null 2> /dev/null
$HG clone ssh://hg@bitbucket.org/zbisch/zbin > /dev/null 2> /dev/null
python ~/code/zconfigs/makeSymLinks.py > /dev/null 2> /dev/null
