set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set brown (set_color brown)
set gray (set_color -o black)
set red (set_color red)

set THEME_GIT_PROMPT_UNTRACKED "$magenta?$normal"
set THEME_GIT_PROMPT_ADDED "$green+$normal"
set THEME_GIT_PROMPT_MODIFIED "$yellow⚡$normal"
set THEME_GIT_PROMPT_RENAMED "$yellow↬$normal"
set THEME_GIT_PROMPT_DELETED "$red×$normal"
set THEME_GIT_PROMPT_UNMERGED "$red⇏$normal"

function git_currentbranch
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function git_prompt
    if git rev-parse --show-toplevel >/dev/null 2>&1
        printf "$normal on $magenta%s$normal" (git_currentbranch)
        git_prompt_status
        set_color normal
    end
end

# Get the status of the working tree
function git_prompt_status
  set INDEX (git status --porcelain 2> /dev/null)
  set STATUS ""
  if echo $INDEX | grep '^?? '> /dev/null
    set STATUS "$THEME_GIT_PROMPT_UNTRACKED$STATUS"
  end
  if echo $INDEX | grep '^A  '> /dev/null; or echo $INDEX | grep '^M  '> /dev/null
    set STATUS "$THEME_GIT_PROMPT_ADDED$STATUS"
  end
  if echo $INDEX | grep '^ M '> /dev/null; or echo $INDEX | grep '^AM '> /dev/null; or echo $INDEX | grep '^ T '> /dev/null
    set STATUS "$THEME_GIT_PROMPT_MODIFIED$STATUS"
  end
  if echo $INDEX | grep '^R  '> /dev/null
    set STATUS "$THEME_GIT_PROMPT_RENAMED$STATUS"
  end
  if echo $INDEX | grep '^ D '> /dev/null; or echo "$INDEX" | grep '^AD '> /dev/null
    set STATUS "$THEME_GIT_PROMPT_DELETED$STATUS"
  end
  if echo $INDEX | grep '^UU '> /dev/null
    set STATUS "$THEME_GIT_PROMPT_UNMERGED$STATUS"
  end
  printf $STATUS
end
