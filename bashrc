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
export PATH="${PATH}:/opt/homebrew/opt/openvpn/sbin/"
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
export PATH="${PATH}:$HOME/sqlplus"
if ( ls /opt/homebrew/opt/tcl-tk &> /dev/null);then
	export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
	export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
	export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
fi
if ( which pyenv &> /dev/null );then
	latest=$(pyenv install --list | grep -E "^\s*3\.[0-9]+\.[0-9]+$" | tail -1 | tr -d ' ')
	global="$(cat $HOME/.pyenv/version)"
	if ( echo "${global}" | grep "$latest" );then
		echo "Using Python ${global}"
	else
	 pyenv install "$latest" << EOF
N
EOF
	 pyenv global "$latest"
		${HOME}/.pyenv/versions/$(cat $HOME/.pyenv/version)/bin/python3 -m venv $HOME/.venv
	fi
	${HOME}/.pyenv/versions/$(cat $HOME/.pyenv/version)/bin/python3 -m venv $HOME/.venv
else
	find /Library/Frameworks/Python.framework/Versions -name 'python3' -exec {} -m venv ${HOME}/.venv \;
fi
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
	docker run -d -p 1521:1521 -e ORACLE_PASSWORD=oracle -v oracle-volume:/opt/oracle/oradata gvenzl/oracle-xe &> /dev/null &
fi
if ( which docker &> /dev/null );then
	docker rm -f mysql-container &> /dev/null &
	docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=1234 -v mysql-volume:/var/lib/mysql -p 3306:3306 -d mysql:5.7 &> /dev/null &
fi
cd $HOME
git clone https://github.com/TaYaKi71751-mac-config/etc &> /dev/null
cd etc
if ( git pull | grep "Already up to date." );then
	FILE_LIST="$(find $PWD -type f)"
	while IFS= read -r FILE_PATH
	do
		ETC_FILE_PATH="$(echo "$FILE_PATH" | sed "s,${HOME},,g")"
		diff "${FILE_PATH}" "${ETC_FILE_PATH}"
		exit_code=$?
		if [ $exit_code -eq 1 ];then
			echo Updating /etc/
			sudo cp -R .nvimlog /etc/
			sudo cp -R .git /etc/
			sudo cp -R .gitignore /etc/
			sudo cp -R * /etc/
			source /etc/bashrc
		elif [ $exit_code -eq 2 ];then
			echo Updating /etc/
			sudo cp -R .nvimlog /etc/
			sudo cp -R .git /etc/
			sudo cp -R .gitignore /etc/
			sudo cp -R * /etc/
			source /etc/bashrc
		fi
	# https://unix.stackexchange.com/questions/9784/how-can-i-read-line-by-line-from-a-variable-in-bash
	done < <(printf '%s\n' "${FILE_LIST}")
else
	sudo cp -R * /etc/
	source /etc/bashrc
fi
cd $HOME
