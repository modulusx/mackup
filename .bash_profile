# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
launchctl setenv JAVA_HOME `/usr/libexec/java_home`
export JAVA_HOME=`/usr/libexec/java_home`
export GOPATH="${HOME}/Data/Repos/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

alias l='ls -hlG'
alias ll='ls -halG'
alias govi='set -o vi'
alias vihosts='sudo vi /etc/hosts'
alias flushdns='sudo killall -HUP mDNSResponder'
alias pings='ping -c2'
alias digs='dig +short'
alias digns='dig +short NS'
alias keygen='openssl rand -base64 16 | colrm 17'
alias shasum256='shasum -a 256'
alias mydate='date +"%F %T"'
alias goblue='blueutil -p 1'
alias noblue='blueutil -p 0'
alias cdatp='cd ~/Data/Repos/sfdcit/aws-tf/proj/'
alias cdc='pwd | pbcopy'
alias cdp='cd $(pbpaste)'
alias ssh-keyprint="cut -d ' ' -f2 | base64 -D | md5 | sed 's/../&:/g; s/:$//'"
alias mrkprfs='defaults write NSGlobalDomain AppleShowAllExtensions -bool false && killall Finder && killall Spotlight'

alias sshinv='ssh $(cat inventory)'
alias sshmod='ssh -i ~/.ssh/id_rsa_modulusx'
alias sshmrk='ssh -i ~/.ssh/id_rsa_mrkunkel'

alias dps='docker ps'
alias dpsa='docker ps -a'
alias drmall='docker rm $(docker ps -aq)'

alias gr='git remote -v'
alias gs='git status'
alias gsu='git status -uno'
alias gcom='git checkout origin/master'
alias groot='git rev-parse --show-toplevel'

alias jbuild='docker run --rm --label=jekyll --volume="$(pwd):/srv/jekyll" -it jekyll/jekyll:3.8.5 jekyll build'
alias jserve='docker run --rm --label=jekyll --volume="$(pwd):/srv/jekyll" -it -p 127.0.0.1:4000:4000 jekyll/jekyll:3.8.5 jekyll serve'

alias kube='kubectl'
alias kubeexec='kubectl run busybox --image=busybox:1.28 --rm -it --restart=Never --command --'

alias tfi='terraform init'
alias tff='terraform fmt'
alias tfv='terraform validate'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfro='terraform refresh && terraform output'
alias tfd='terraform destroy'
alias tfda='terraform destroy -auto-approve'

alias awswhoami='aws sts get-caller-identity --profile'
alias awsssprod='yubi aws && pbpaste | aws-mfa'

mkcd () {
    mkdir -p $1
    cd $1
}

yubi () {
  if [ $# -eq 0 ]
  then
    ykman oath code && sleep 4 && clear
  else
    ykman oath code $1 | awk -F' ' '{print $2}' | pbcopy
  fi
}

dansible () {
  docker run --rm -it --label=ansible \
                  --volume="$(dirname ~/.aws/)/.aws/:/root/.aws/:ro" \
                  --volume="$(dirname ~/.ssh/)/.ssh/:/root/.ssh/:ro" \
                  --volume="$(pwd):/project" \
                  ansible/ansible:default $@
}

dterraform () {
  prjwd=$(pwd)
  prjroot=$(git rev-parse --show-toplevel)
  prjpath=${prjwd#"$prjroot"}
  docker run --rm -it --label=terraform \
                  --volume="$(dirname ~/.aws/)/.aws/:/root/.aws/:ro" \
                  --volume="$(dirname ~/.ssh/)/.ssh/:/root/.ssh/:ro" \
                  --volume="$prjroot:/project" \
                  -w="/project$prjpath" \
                  hashicorp/terraform:0.11.13 $@
}

gbup () {
  git branch --set-upstream-to=origin/$1 $1
}

gcmrk () {
  MRKREPO=$(echo $1 | sed -e 's/github.com/github.com.mrk/')
  git clone $MRKREPO
}

grmrk () {
  MRKREPO=$(git remote -v | awk -F' ' '{print $2}' | head -n1 | sed -e 's/github.com/github.com.mrk/')
  git remote remove origin
  git remote add origin $MRKREPO
  git remote -v
}

gcmod () {
  MODREPO=$(echo $1 | sed -e 's/github.com/github.com.mod/')
  git clone $MODREPO
}

grmod () {
  MODREPO=$(git remote -v | awk -F' ' '{print $2}' | head -n1 | sed -e 's/github.com/github.com.mod/')
  git remote remove origin
  git remote add origin $MODREPO
  git remote -v
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local EXIT="$?"
    PS1=""

    local RCol='\[\e[0m\]'
    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BBlu='\[\e[1;34m\]'

    if [ $EXIT != 0 ]; then
        PS1+="\n${Red}\W${RCol}"
    else
        PS1+="\n${Gre}\W${RCol}"
    fi
    PS1+="${RCol}${BBlu}\$(parse_git_branch) ${RCol}$ "
}

# Standard brew bash completion
for bcfile in /usr/local/etc/bash_completion.d/* ; do
  . $bcfile
done
