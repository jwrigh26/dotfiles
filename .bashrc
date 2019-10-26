#MY STUFF GOES HERE
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# vim to nvim
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

#Please check your go environment variables by running $go env | grep -i "^GO"
export GOROOT=/usr/local/go
export GOPATH=$HOME/Workspace/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GO111MODULE=off

#Run go project
alias rungo='cd ~/Workspace/go/src/scrapping/sakihara && go build main.go && go run main.go && echo -e "\n\n"'
