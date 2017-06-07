# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	    . /etc/bashrc
fi

export EDITOR="vim"

alias mkcscope='~/.vim/mkcscope.sh'

alias echob='echo b > /proc/sysrq-trigger'
alias echoc='echo c > /proc/sysrq-trigger'
alias echot='echo t > /proc/sysrq-trigger'

alias l='ll -h'
alias la='ll -ah'
alias cls='clear'
alias ls='ls -p'
alias df='df -h'
alias du='du --max-depth=1 -h'


ulimit -c unlimited
alias vi="vim"
alias ps.eo='ps -eo pid,args,wchan'
alias ps.pts='ps -ef | grep pts'
alias ps.alx='ps -alx'
alias vimsg='vi /var/log/messages'
alias clrmsg='> /var/log/messages'
alias tailmsg='tail -f /var/log/messages'

alias mkobj='objdump -d -l kernel_module.ko > obj'

alias iostat='iostat -p -xd -m 1'

unset USERNAME

unset SYSDIR
SYSDIR=${HOME}/.cs
export SYSDIR

#export LS_COLORS="di=01;34"

#alias export_proxy='export http_proxy=proxy_server_ip:port'
alias tmux='TERM=xterm-256color tmux -2'

alias dropcache='echo 3 > /proc/sys/vm/drop_caches'

function gitdiff(){
	git difftool -y -t vimdiff
}

