export def git_current_branch [] {
    (gstat).branch
}

export def git_main_branch [] {
    git remote show origin
        | lines
        | str trim
        | find --regex 'HEAD .*?[：: ].+'
        | first
        | str replace --regex 'HEAD .*?[：: ]\s*(.+)' '$1'
}

export def glog [num?: int=5] {
    git log --pretty=%h»¦«%s»¦«%aN»¦«%aE»¦«%aD -n $num | lines | split column "»¦«" commit subject name email date | upsert date {|d| $d.date | into datetime} | sort-by date | reverse
}

export def grank [] {
  git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | histogram committer merger | sort-by merger | reverse
}

export def gtime [] {
  # 获取所有提交记录并按作者分组
  git log --pretty=format:"%aN»¦«%aI" |
    lines |
    split column "»¦«" author date |
    group-by author |
    items {|author, records|
      # 获取每个作者的时间记录并排序
      let dates = $records | get date
      let sorted = $dates | sort
      # 提取首次和最后提交时间
      {
        author: $author
        first_commit: ($sorted | first)
        last_commit: ($sorted | last)
        commits: ($records | length)
        active_days: ((($sorted | last | into datetime) - ($sorted | first | into datetime)) / 1day | into int)
      }
    } |
    # 按最后提交时间倒序排列
    sort-by last_commit -r
}

# edit .gitignore
export def gig [--empty-dir] {
    if $empty_dir {
        [
            '# Ignore everything in this directory'
            '*'
            '# Except this file'
            '!.gitignore'
        ] | str join (char newline) | save .gitignore
    } else {
        ^$env.EDITOR $"(git rev-parse --show-toplevel)/.gitignore"
    }
}

export def gst [] {
    # TODO: show-stash
    let raw_status = do -i { git --no-optional-locks status --porcelain=2 --branch | lines }

    let stashes = do -i { git stash list | lines | length }

    mut status = {
        idx_added_staged    : 0
        idx_modified_staged : 0
        idx_deleted_staged  : 0
        idx_renamed         : 0
        idx_type_changed    : 0
        wt_untracked        : 0
        wt_modified         : 0
        wt_deleted          : 0
        wt_type_changed     : 0
        wt_renamed          : 0
        ignored             : 0
        conflicts           : 0
        ahead               : 0
        behind              : 0
        stashes             : $stashes
        repo_name           : no_repository
        tag                 : no_tag
        branch              : no_branch
        remote              : ''
    }

    if ($raw_status | is-empty) { return $status }

    for s in $raw_status {
        let r = $s | split row ' '
        match $r.0 {
            '#' => {
                match ($r.1 | str substring 7..) {
                    'oid' => {
                        $status.commit_hash = ($r.2 | str substring 0..8)
                    }
                    'head' => {
                        $status.branch = $r.2
                    }
                    'upstream' => {
                        $status.remote = $r.2
                    }
                    'ab' => {
                        $status.ahead = ($r.2 | into int)
                        $status.behind = ($r.3 | into int | math abs)
                    }
                }
            }
            '1'|'2' => {
                match ($r.1 | str substring 0..1) {
                    'A' => {
                        $status.idx_added_staged += 1
                    }
                    'M' => {
                        $status.idx_modified_staged += 1
                    }
                    'R' => {
                        $status.idx_renamed += 1
                    }
                    'D' => {
                        $status.idx_deleted_staged += 1
                    }
                    'T' => {
                        $status.idx_type_changed += 1
                    }
                }
                match ($r.1 | str substring 1..2) {
                    'M' => {
                        $status.wt_modified += 1
                    }
                    'R' => {
                        $status.wt_renamed += 1
                    }
                    'D' => {
                        $status.wt_deleted += 1
                    }
                    'T' => {
                        $status.wt_type_changed += 1
                    }
                }
            }
            '?' => {
                $status.wt_untracked += 1
            }
            'u' => {
                $status.conflicts += 1
            }
        }
    }

    $status
}

#
# Aliases
# (sorted alphabetically)
#

export alias ga = git add
export alias gaa = git add --all
export alias gapa = git add --patch
export alias gau = git add --update
export alias gav = git add --verbose
export alias gap = git apply
export alias gapt = git apply --3way

export alias gb = git branch
export alias gba = git branch --all
export alias gbd = git branch --delete
export alias gbD = git branch --delete --force
export alias gbl = git blame -b -w
export alias gbm = git branch --move
export alias gbmc = git branch --move (git_current_branch)
export alias gbnm = git branch --no-merged
export alias gbr = git branch --remote
export alias gbs = git bisect
export alias gbsb = git bisect bad
export alias gbsg = git bisect good
export alias gbsn = git bisect new
export alias gbso = git bisect old
export alias gbsr = git bisect reset
export alias gbss = git bisect start

export alias gc = git commit --verbose
export alias gc! = git commit --verbose --amend
export alias gcn = git commit --verbose --no-edit
export alias gcn! = git commit --verbose --no-edit --amend
export alias gca = git commit --verbose --all
export alias gca! = git commit --verbose --all --amend
export alias gcan! = git commit --verbose --all --no-edit --amend
export alias gcans! = git commit --verbose --all --signoff --no-edit --amend
export alias gcam = git commit --all --message
export alias gcsm = git commit --signoff --message
export alias gcas = git commit --all --signoff
export alias gcasm = git commit --all --signoff --message
export alias gcb = git checkout -b
export alias gcd = git checkout develop
export alias gcf = git config --list

export alias gcl = git clone --recurse-submodules
export alias gscl = git clone --depth=1
export alias gclean = git clean --interactive -d
export def gpristine [] {
    git reset --hard
    git clean -d --force -x
}
export alias gcm = git checkout (git_main_branch)
export alias gcmsg = git commit --message
export alias gco = git checkout
export alias gcor = git checkout --recurse-submodules
export alias gcount = git shortlog --summary --numbered
export alias gcp = git cherry-pick
export alias gcpa = git cherry-pick --abort
export alias gcpc = git cherry-pick --continue
export alias gcs = git commit --gpg-sign
export alias gcss = git commit --gpg-sign --signoff
export alias gcssm = git commit --gpg-sign --signoff --message

export alias gd = git diff
export alias gdca = git diff --cached
export alias gdcw = git diff --cached --word-diff
export alias gdct = git describe --tags (git rev-list --tags --max-count=1)
export alias gds = git diff --staged
export alias gdt = git diff-tree --no-commit-id --name-only -r
export alias gdup = git diff @{upstream}
export alias gdw = git diff --word-diff

export alias gf = git fetch
export alias gfa = git fetch --all --prune
export alias gfo = git fetch origin

export alias gignore = git update-index --assume-unchanged

# logs
export alias gl = git log
export alias glg = git log --stat
export alias glgp = git log --stat --patch
export alias glgg = git log --graph
export alias glgga = git log --graph --decorate --all
export alias glgm = git log --graph --max-count=10
export alias glo = git log --oneline --decorate

export alias gm = git merge
export alias gmtl = git mergetool --no-prompt
export alias gmtlvim = git mergetool --no-prompt --tool=vimdiff
export alias gma = git merge --abort
export def gmom [] {
    let main = (git_main_branch)
    git merge $"origin/($main)"
}

export alias gp = git push
export alias gpd = git push --dry-run
export alias gpf = git push --force-with-lease
export alias gpf! = git push --force
export alias gpl = git pull
export def gpoat [] {
    git push origin --all; git push origin --tags
}
export alias gpod = git push origin --delete
export alias gpodc = git push origin --delete (git_current_branch)
export alias gpr = git pull --rebase
export alias gpu = git push upstream
export alias gpv = git push --verbose

export alias gr = git remote
export alias gpra = git pull --rebase --autostash
export alias gprav = git pull --rebase --autostash --verbose
export alias gprv = git pull --rebase --verbose
export alias gpsup = git push --set-upstream origin (git_current_branch)
export alias gra = git remote add
export alias grb = git rebase
export alias grba = git rebase --abort
export alias grbc = git rebase --continue
export alias grbd = git rebase develop
export alias grbi = git rebase --interactive
export alias grbm = git rebase (git_main_branch)
export alias grbo = git rebase --onto
export alias grbs = git rebase --skip
export alias grev = git revert
export alias grh = git reset
export alias grhh = git reset --hard
export alias groh = git reset $"origin/(git_current_branch)" --hard
export alias grm = git rm
export alias grmc = git rm --cached
export alias grs = git restore
export alias grss = git restore --source
export alias grst = git restore --staged
export alias grt = cd (git rev-parse --show-toplevel or echo .)
export alias gru = git reset --
export alias grup = git remote update
export alias grv = git remote --verbose

export alias gsb = git status --short --branch
export alias gsd = git svn dcommit
export alias gsh = git show
export alias gshs = git show -s
export alias gsi = git submodule init
export alias gsps = git show --pretty=short --show-signature
export alias gsr = git svn rebase
export alias gss = git status --short

export alias gsta = git stash push
export alias gstaa = git stash apply
export alias gstc = git stash clear
export alias gstd = git stash drop
export alias gstl = git stash list
export alias gstp = git stash pop
export alias gsts = git stash show --text
export alias gstu = gsta --include-untracked
export alias gstall = git stash --all
export alias gsu = git submodule update
export alias gsw = git switch
export alias gswc = git switch --create

export alias gts = git tag --sign
export def gtv [] {
    git tag | lines | sort
}
export alias glum = git pull upstream (git_main_branch)

export alias gunignore = git update-index --no-assume-unchanged
export alias gup = git pull --rebase
export alias gupv = git pull --rebase --verbose
export alias gupa = git pull --rebase --autostash
export alias gupav = git pull --rebase --autostash --verbose

export alias gwch = git whatchanged -p --abbrev-commit --pretty=medium

export alias gwt = git worktree
export alias gwta = git worktree add
export alias gwtls = git worktree list
export alias gwtmv = git worktree move
export alias gwtrm = git worktree remove

export alias gam = git am
export alias gamc = git am --continue
export alias gams = git am --skip
export alias gama = git am --abort
export alias gamscp = git am --show-current-patch
