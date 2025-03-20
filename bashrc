# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

export EMSDK_QUIET=1
export NLS_LANG=KOREAN_KOREA.AL32UTF8 
export PATH="/usr/local/bin:${PATH}"
export LD_LIBRARY_PATH=$HOME/bin/oracle:$LD_LIBRARY_PATH
export PATH=$LD_LIBRARY_PATH:$PATH
export PATH="${PATH}:/opt/homebrew/bin"
export PATH="${PATH}:/usr/local/opt/openvpn/sbin"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$PATH:$HOME/Library/Android/sdk/tools"
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
export ANDROID_HOME="$HOME/Library/Android/sdk"
if ( /usr/libexec/java_home &> /dev/null );then
	export JAVA_HOME="$(/usr/libexec/java_home)"
else
	export JAVA_HOME="/opt/homebrew/opt/openjdk"
	export PATH="${JAVA_HOME}/bin:$PATH"
fi
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
/usr/bin/python3 -m venv ${HOME}/.venv &
export PATH="${HOME}/.venv/bin:${PATH}"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
eval "$(rbenv init - bash)"
source "${HOME}/emsdk/emsdk_env.sh"
export PATH="${PATH}:${HOME}/emsdk"
export PATH="${PATH}:${HOME}/emsdk/upstream/emscripten"
. "$HOME/.cargo/env"
export RUSTUP_HOME="${HOME}/.rustup"
export CARGO_HOME="${HOME}/.cargo"
export PATH="${PATH}:${HOME}/.cargo/bin"
if ( which colima &> /dev/null );then
	colima start --arch x86_64 --memory 4 &> /dev/null &
fi
if ( which docker &> /dev/null );then
	docker run -d -p 1521:1521 -e ORACLE_PASSWORD=oracle -v oracle-volume:/opt/oracle/oradata gvenzl/oracle-xe &> /dev/null
fi
