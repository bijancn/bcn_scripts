#!/bin/sh
# SVN Diff Wrapper

# Configure your favorite diff program here
#DIFF="vimdiff -f"
DIFF="meld"

# Subversion provides the paths we need as the sixth and seventh parameters
left="$6"
right="$7"

$DIFF $LEFT $RIGHT
