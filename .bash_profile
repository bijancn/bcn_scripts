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

export TERM=xterm-256color
source .bashrc
source ~/bashrc-tmux/bashrc-tmux

# old screen variant
#if test "$TERM" != "screen" -a "$SSH_CONNECTION" != "" -a `getconf LONG_BIT` = 64; then
  #$HOME/install/bin/screen -U -S sshscreen -d -R && exit
#else
  #. .bashrc
#fi
