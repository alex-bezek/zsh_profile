echo 'Setup brew taps and casks'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle


echo 'Setup zsh'
cp .zshrc.bak.sh ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
chsh -s /bin/zsh

echo 'Setup basic folder'
mkdir ~/code
mkdir ~/code/personal
mkdir ~/code/work

echo 'Setup hammerspoon spoon installer'
HAMMERSPOON_HOME=~/.hammerspoon2
echo "$HAMMERSPOON_HOME"
mkdir "$HAMMERSPOON_HOME"
mkdir "$HAMMERSPOON_HOME/Spoons"
curl -SL https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip | tar -xf - -C ~/.hammerspoon/Spoons
cp -R ./hammerspon ~/.hammerpoon
