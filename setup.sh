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

echo 'Setup ssh config'
touch ~/.ssh/config
cat <<EOT >> ~
Host ssh.spherestage.com
  LocalForward 2001 127.0.0.1:8080
Host ssh.cernuksphere.net
  LocalForward 2002 127.0.0.1:8080
Host ssh.cernersphere.com
  LocalForward 2003 127.0.0.1:8080
Host ssh.us-west-2.devhealtheintent.com
  LocalForward 2004 127.0.0.1:8080
Host ssh.us-west-2.staginghealtheintent.com
  LocalForward 2005 127.0.0.1:8080
Host ssh.us-west-2.healtheintent.com
  LocalForward 2006 127.0.0.1:8080
Host ssh.ca.cernerasp.cernerops.com
  LocalForward 2007 127.0.0.1:8080
Host ssh.au.cernerasp.cernerops.com
  LocalForward 2008 127.0.0.1:8080
EOT

echo 'Setup pacfile'
curl -o ~/pacfile https://raw.github.cerner.com/ETS/workstation-config/master/ets.pac
sudo networksetup -setautoproxyurl Wi-Fi http://localhost:5000/pacfile
