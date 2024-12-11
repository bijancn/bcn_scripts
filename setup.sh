if ! ps aux | grep -v grep | grep Hammerspoon > /dev/null; then
    echo "Hammerspoon is not running. Starting it..."
    open -a Hammerspoon
else
    echo "Hammerspoon is already running."
fi

