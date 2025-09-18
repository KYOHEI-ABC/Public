# mac
```
sudo find /private/var/folders/ -type f -iname "InstallAssistant.pkg.partial" 2>/dev/null

diskutil list
diskutil eraseDisk HFS+ "volume" GPT /dev/diskX

echo "PS1='%d '" > ~/.zshrc

git config --global user.name "KyoheiAbc"
git config --global user.email "autumn8november@gmail.com"

defaults write com.apple.finder AppleShowAllFiles TRUE
defaults write com.apple.dock tilesize -int 48 && killall Dock
```
