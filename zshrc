# System-wide profile for interactive zsh(1) shells.

# Setup user specific overrides for this in ~/.zshrc. See zshbuiltins(1)
# and zshoptions(1) for more details.

# Correctly display UTF-8 with combining characters.  We'll assume UTF-8 if the
# locale(1) binary is missing entirely.
if [[ ! -x /usr/bin/locale ]] || [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
    setopt COMBINING_CHARS
fi

# Disable the log builtin, so we don't conflict with /usr/bin/log
disable log

# Save command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=2000
SAVEHIST=1000

# Beep on error
setopt BEEP

# Use keycodes (generated via zkbd) if present, otherwise fallback on
# values from terminfo
if [[ -r ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR} ]] ; then
    source ${ZDOTDIR:-$HOME}/.zkbd/${TERM}-${VENDOR}
else
    typeset -g -A key

    [[ -n "$terminfo[kf1]" ]] && key[F1]=$terminfo[kf1]
    [[ -n "$terminfo[kf2]" ]] && key[F2]=$terminfo[kf2]
    [[ -n "$terminfo[kf3]" ]] && key[F3]=$terminfo[kf3]
    [[ -n "$terminfo[kf4]" ]] && key[F4]=$terminfo[kf4]
    [[ -n "$terminfo[kf5]" ]] && key[F5]=$terminfo[kf5]
    [[ -n "$terminfo[kf6]" ]] && key[F6]=$terminfo[kf6]
    [[ -n "$terminfo[kf7]" ]] && key[F7]=$terminfo[kf7]
    [[ -n "$terminfo[kf8]" ]] && key[F8]=$terminfo[kf8]
    [[ -n "$terminfo[kf9]" ]] && key[F9]=$terminfo[kf9]
    [[ -n "$terminfo[kf10]" ]] && key[F10]=$terminfo[kf10]
    [[ -n "$terminfo[kf11]" ]] && key[F11]=$terminfo[kf11]
    [[ -n "$terminfo[kf12]" ]] && key[F12]=$terminfo[kf12]
    [[ -n "$terminfo[kf13]" ]] && key[F13]=$terminfo[kf13]
    [[ -n "$terminfo[kf14]" ]] && key[F14]=$terminfo[kf14]
    [[ -n "$terminfo[kf15]" ]] && key[F15]=$terminfo[kf15]
    [[ -n "$terminfo[kf16]" ]] && key[F16]=$terminfo[kf16]
    [[ -n "$terminfo[kf17]" ]] && key[F17]=$terminfo[kf17]
    [[ -n "$terminfo[kf18]" ]] && key[F18]=$terminfo[kf18]
    [[ -n "$terminfo[kf19]" ]] && key[F19]=$terminfo[kf19]
    [[ -n "$terminfo[kf20]" ]] && key[F20]=$terminfo[kf20]
    [[ -n "$terminfo[kbs]" ]] && key[Backspace]=$terminfo[kbs]
    [[ -n "$terminfo[kich1]" ]] && key[Insert]=$terminfo[kich1]
    [[ -n "$terminfo[kdch1]" ]] && key[Delete]=$terminfo[kdch1]
    [[ -n "$terminfo[khome]" ]] && key[Home]=$terminfo[khome]
    [[ -n "$terminfo[kend]" ]] && key[End]=$terminfo[kend]
    [[ -n "$terminfo[kpp]" ]] && key[PageUp]=$terminfo[kpp]
    [[ -n "$terminfo[knp]" ]] && key[PageDown]=$terminfo[knp]
    [[ -n "$terminfo[kcuu1]" ]] && key[Up]=$terminfo[kcuu1]
    [[ -n "$terminfo[kcub1]" ]] && key[Left]=$terminfo[kcub1]
    [[ -n "$terminfo[kcud1]" ]] && key[Down]=$terminfo[kcud1]
    [[ -n "$terminfo[kcuf1]" ]] && key[Right]=$terminfo[kcuf1]
fi

# Default key bindings
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search

# Default prompt
PS1="%n@%m %1~ %# "

# Useful support for interacting with Terminal.app or other terminal programs
[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"

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
export PATH="$PATH:$HOME/Library/Android/sdk/cmdline-tools/latest/bin"
export ANDROID_HOME="$HOME/Library/Android/sdk"
if ( /usr/libexec/java_home &> /dev/null );then
	export JAVA_HOME="$(/usr/libexec/java_home)"
else
	export JAVA_HOME="/opt/homebrew/opt/openjdk"
	export PATH="${JAVA_HOME}/bin:$PATH"
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
TEMURIN_JAVA_PATH="$(find /Library/Java/JavaVirtualMachines -type d -maxdepth 1 -name 'temurin-*' | head -n 1)"
if ( ls "${TEMURIN_JAVA_PATH}" &> /dev/null );then
	export JAVA_HOME="${TEMURIN_JAVA_PATH}/Contents/Home"
	export PATH="${JAVA_HOME}/bin:$PATH"
fi
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export PATH="${PATH}:$HOME/sqlplus"
if ( ls /opt/homebrew/opt/tcl-tk &> /dev/null );then
	export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
	export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
	export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
fi
if ( ls $HOME/.config/pyenv.auto_update &> /dev/null );then
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
fi
export PATH="${HOME}/flutter/bin:$PATH"
	export PATH="${HOME}/.venv/bin:${PATH}"
	export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
	RUBY_GEMS_PATH="$(find /opt/homebrew/lib/ruby/gems/ -type d -maxdepth 1 -mindepth 1 | head -n 1)/bin"
	export PATH="${RUBY_GEMS_PATH}:${PATH}"
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
if ( ls $HOME/.config/etc.auto_update &> /dev/null );then
	cd $HOME
	git clone https://github.com/TaYaKi71751-mac-config/etc &> /dev/null
	if ( ls $HOME/etc &> /dev/null );then
		cd $HOME/etc
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
	fi
fi
cd $HOME
