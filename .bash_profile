# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# bcn .bash_profile - executed by the command interpreter for login shells
#
# Copyright (C)              Bijan Chokoufe Nejad         <bijan@chokoufe.com>
# Recent versions:  https://github.com/bijancn/bcn_scripts
#
# This source code is free software that comes with ABSOLUTELY NO WARRANTY; you
# can redistribute it and/or modify it under the terms of the GNU GPL Version 2:
# http://www.gnu.org/licenses/gpl-2.0-standalone.html
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

source $HOME/.bashrc
if [ -d ~/bashrc-tmux ]; then
  source ~/bashrc-tmux/bashrc-tmux
fi

# old screen variant
#if test "$TERM" != "screen" -a "$SSH_CONNECTION" != "" -a `getconf LONG_BIT` = 64; then
  #$HOME/install/bin/screen -U -S sshscreen -d -R && exit
#else
  #. .bashrc
#fi

# added by Miniconda2 installer
export PATH="$HOME/miniconda2/bin:$PATH"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/bijan/.sdkman"
[[ -s "/Users/bijan/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bijan/.sdkman/bin/sdkman-init.sh"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/bcn/.lmstudio/bin"
# End of LM Studio CLI section

