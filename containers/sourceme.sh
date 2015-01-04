# Docker aliases
alias d="docker"
alias dr="docker rm"
alias dr_all="docker rm $(docker ps -a -q)"
alias dsp="docker stop"
alias dsp_all="docker stop $(docker ps -a -q)"

# Fleet aliases
alias fc="fleetctl"
alias fcst="fleetctl start"
alias fcsp="fleetctl stop"
alias fcd="fleetctl destroy"
alias fcj="fleetctl journal"
alias fclu="fleetctl list-units"
alias fcluf="fleetctl list-unit-files"
alias fcssh="fleetctl ssh"

# Etcd aliases
alias ec="etcdctl"
alias ecls="etcdctl ls"
alias ecg="etcdctl get"
alias ecs="etcdctl set"
