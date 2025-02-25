set -e

for b in `cat brew-list-cask`; do
    brew install --cask $b
done

for b in `cat brew-list`; do
    brew install $b
done

if ! ps aux | grep -v grep | grep Hammerspoon > /dev/null; then
    echo "Hammerspoon is not running. Starting it..."
    open -a Hammerspoon
else
    echo "Hammerspoon is already running."
fi

wget https://github.com/Hammerspoon/Spoons/raw/master/Spoons/WindowHalfsAndThirds.spoon.zip
unzip WindowHalfsAndThirds.spoon.zip
open WindowHalfsAndThirds.spoon
rm -f WindowHalfsAndThirds.spoon.zip

wget https://github.com/miromannino/miro-windows-manager/raw/master/MiroWindowsManager.spoon.zip
unzip MiroWindowsManager.spoon.zip
open MiroWindowsManager.spoon
rm -f MiroWindowsManager.spoon.zip

rm -rf __MACOSX/

npm install -g neovim
cpanm -n Neovim::Ext
sudo gem install neovim
