# Useful aliases  {{{
alias ls 'ls -alFGh'
alias ... 'cd ../..'

alias svnignore 'svn propset svn:ignore -F .svnignore .'
set -U SVN_EDITOR 'vim'

alias g "mvim --remote-silent"

# }}}
# Environment variables {{{

set PATH "/usr/local/bin"          $PATH
set PATH "/usr/local/sbin"         $PATH
set PATH "$HOME/bin"               $PATH
set PATH "/usr/local/share/python" $PATH 


set -g -x EDITOR vim
set -g -x COMMAND_MODE unix2003
set -U GREP_OPTIONS '--color=auto'

# }}}
# Python variables {{{

set -g -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
# set -g -x PYTHONSTARTUP "$HOME/.pythonrc.py"

# set PATH $PATH "/usr/local/Cellar/python/2.7.2/bin"
# set PATH $PATH "/Developer/usr/bin/"

set -g -x PYTHONPATH ""
# set PYTHONPATH "$HOME/lib/python/see:$PYTHONPATH"
set PYTHONPATH "$HOME/lib/hg/hg:$PYTHONPATH"

set -gx WORKON_HOME "$HOME/.virtualenvs"
. ~/.config/fish/virtualenv.fish

# }}}
# Z {{{

. ~/src/z-fish/z.fish

# }}}


# Prompt {{{

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set gray (set_color -o black)
set hg_promptstring "☿< on $magenta<branch>$normal>< at $yellow<tags|$normal, $yellow>$normal>$green<status|modified|unknown><update>$normal<
patches: <patches|join( → )|pre_applied($yellow)|post_applied($normal)|pre_unapplied($gray)|post_unapplied($normal)>>" 2>/dev/null

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf '(%s) ' (basename "$VIRTUAL_ENV")
    end
end

function hg_prompt
    # hg prompt --angle-brackets $hg_promptstring 2>/dev/null
end


. ~/.config/fish/git.fish

function fish_prompt
    set last_status $status

    z --add "$PWD"

    echo

    printf '%s%s%s at %s%s' (set_color magenta) (whoami) (set_color normal) (set_color yellow) (hostname|cut -d . -f 1)
    
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    hg_prompt
    git_prompt

    echo

    virtualenv_prompt

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

# }}}
