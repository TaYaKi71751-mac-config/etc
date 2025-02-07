# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

export PATH="${PATH}:/opt/homebrew/bin"
export PATH="${PATH}:/usr/local/opt/openvpn/sbin"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$PATH:$HOME/Library/Android/sdk/tools"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export ANDROID_HOME="$HOME/Library/Android/sdk"
if ( ls /usr/libexec/java_home > /dev/null );then
	if ( /usr/libexec/java_home );then
		export JAVA_HOME="$(/usr/libexec/java_home)"
	else
		export JAVA_HOME=/usr/local/opt/openjdk@8
	fi
fi
/usr/bin/python3 -m venv ${HOME}/.venv &
export PATH="${HOME}/.venv/bin:${PATH}"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
source "${HOME}/emsdk/emsdk_env.sh"
export PATH="${PATH}:${HOME}/emsdk"
export PATH="${PATH}:${HOME}/emsdk/upstream/emscripten"
. "$HOME/.cargo/env"
export RUSTUP_HOME="${HOME}/.rustup"
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${HOME}/.cargo/bin"
