# Helpful aliases
alias ls="ls -G"
alias l="ls"
alias ll="l -l"
alias la="l -a"
alias lla="l -la"

alias cleanup="rm *~"

# Git Completion
source ~/.git-completion.sh

# Put secret configuration settings in ~/.secrets
if [[ -a ~/.secrets ]] then
    source ~/.secrets
fi

# Go: Combines cd and ls for directories, or opens files in EMACS.
go() {
    cd $1 2> /dev/null && ls || $EDITOR $1
}

export EDITOR=emacs


# Block or unblock Facebook
blockfb() {
    if [ -f /etc/hosts-fb ]; then # Facebook is blocked 
        read -sp "Are you sure you want to unblock Facebook? " response
        if [ $response != "YesI'mfucking*positive*" ]; then
            echo; echo "Sorry, I guess you're not sure."
        else
            echo
            sudo mv /etc/hosts-fb /etc/hosts
            echo "Facebook has been unblocked."
        fi
    else # Block Facebook
        sudo cp /etc/hosts /etc/hosts-fb
        sudo sh -c 'echo "127.0.0.1 facebook.com" >> /etc/hosts'
        sudo sh -c 'echo "127.0.0.1 www.facebook.com" >> /etc/hosts'
        echo "Facebook has been blocked."
    fi
}


# Compile and run Java files in one go.
runjava() {
  file="$1.java"
  javac $file && java $1
}


# Fancy SEAS printing
# Usage: seaspring foo.pdf
function seasprint() {
   cat "$1" | ssh kyleh@eniac.seas.upenn.edu lpr -P169
}

function listprinters() {
   ssh kyleh@eniac.seas.upenn.edu lpstat -o -p -d
}


# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Ron Shapiro's Branch highlighting
#export PS1="\[\e[4;32m\]\w\e[m\]\$(parse_git master) $ "
#function parse_git {
#    git_branch="$(__git_ps1 "%s")"
#    output="${git_branch}"
#    if [[ -z $output ]]; then
#        return
#    fi
#
#    status="$(git status 2> /dev/null)"
#    
#    git_branch="$(__git_ps1 "%s")"
#    # to add a warning for a branch, do `git config --local --add branch.BRANCHNAME.editwarning true` and unset with `git config --local --unset branch.BRANCHNAME.editwarning
#    branch_warning="branch.${git_branch}.editwarning=true"
#    hide="$(git config -l)"
#    
#    if [[ $hide =~ $branch_warning ]]; then
#        output="${bakred} -- ${output} -- ${end}"
#    else
#        output="(${output})"
#    fi
#    
#    if [[ $status =~ "Untracked files" ]]; then
#        output="${txtylw}${output}${end}"
#    elif [[ $status =~ "Changes not staged for commit" ]]; then
#        output="${txtylw}${output}${end}"
#    elif [[ $status =~ "Changes to be committed" ]]; then
#        output="${txtpur}${output}${end}"
#    elif [[ $status =~ "Your branch is ahead" ]]; then
#        output="${txtylw}${output}${end}"
#    elif [[ $status =~ "nothing to commit" ]]; then
#        output="${txtblu}${output}${end}"
#    fi
#
#    echo -e " $output"
#}