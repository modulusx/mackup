# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

alias l='ls -halG'
alias ll='ls -halG'
alias govi='set -o vi'
alias vihosts='sudo vi /etc/hosts'
alias flushdns='sudo killall -HUP mDNSResponder'
alias pings='ping -c2'
alias digs='dig +short'
alias digns='dig +short NS'
alias mydate='date +"%F %T"'
alias goblue='blueutil -p 1'
alias noblue='blueutil -p 0'

alias keygen='openssl rand -base64 16 | colrm 17'

alias sshinv='ssh $(cat inventory)'

alias dps='docker ps'
alias dpsa='docker ps -a'
alias drmall='docker rm $(docker ps -aq)'

alias gs='git status -uno'
alias gcom='git checkout origin/master'

alias jbuild='docker run --rm --label=jekyll --volume="$(pwd):/srv/jekyll" -it jekyll/jekyll:3.8.5 jekyll build'
alias jserve='docker run --rm --label=jekyll --volume="$(pwd):/srv/jekyll" -it -p 127.0.0.1:4000:4000 jekyll/jekyll:3.8.5 jekyll serve'

alias kube='kubectl'
alias kexec='kubectl run busybox --image=busybox:1.28 --rm -it --restart=Never --command --'

mcd () {
    mkdir -p $1
    cd $1
}

gitclonemrk () {
  MRKREPO=$(echo $1 | sed -e 's/github.com/github.com.mrk/')
  git clone $MRKREPO
}

gitremotemrk () {
  MRKREPO=$(git remote -v | awk -F' ' '{print $2}' | head -n1 | sed -e 's/github.com/github.com.mrk/')
  git remote remove origin
  git remote add origin $MRKREPO
}

gitclonemod () {
  MODREPO=$(echo $1 | sed -e 's/github.com/github.com.mod/')
  git clone $MODREPO
}

gitremotemod () {
  MODREPO=$(git remote -v | awk -F' ' '{print $2}' | head -n1 | sed -e 's/github.com/github.com.mod/')
  git remote remove origin
  git remote add origin $MODREPO
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
