# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
export HISTCONTROL=ignoredups
export SVN_EDITOR=vim
export PATH=$PATH:/usr/sbin:/sbin:/usr/java/latest

alias rm="rm -i"
alias num='ll | wc -l'
alias soundup='amixer -c '0' sset Master,0 3+'
alias sounddown='amixer -c '0' sset Master,0 3-'
alias members='cd /var/www/svn/sbbClient/'
alias analytics='cd /var/www/svn/sbbAnalytics/'
alias investors='cd /var/www/svn/sbbInvestors/'
alias bcap='cd /var/www/svn/svnBcap/'
alias svnrevert='_svnrevert'
alias mysqlLocal="su -c 'screen -d -r mysqlLocal'"
alias mysqlDev="su -c 'screen -d -r mysqlDev'"
alias mysqlLive="su -c 'screen -d -r mysqlLive'"


PROMPT_COMMAND=check_error

function check_error {
	ERROR=$?
	if [[ $ERROR != 0 ]];
	then
		echo -e "\e[101mError: $ERROR\e[0m"
	fi
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

