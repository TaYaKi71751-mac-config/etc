# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

export PATH="${PATH}:/usr/local/opt/openvpn/sbin"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$PATH:$HOME/Library/Android/sdk/tools"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export ANDROID_HOME="$HOME/Library/Android/sdk"
/usr/bin/python3 -m venv ${HOME}/.venv &
export PATH="${HOME}/.venv/bin:${PATH}"
export PATH="/usr/local/opt/ruby/bin:$PATH"
