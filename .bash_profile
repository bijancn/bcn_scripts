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

# added by Miniconda2 installer
export PATH="$HOME/miniconda2/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/bijan/.sdkman"
[[ -s "/Users/bijan/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bijan/.sdkman/bin/sdkman-init.sh"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/bcn/.lmstudio/bin"
# End of LM Studio CLI section
