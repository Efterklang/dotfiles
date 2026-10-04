def cd-completer [token: record] {
    let input = $token.text

    let local_dirs = (
        $input
        | commandline complete --type directory
    )

    # 路径补全交给 Nushell，不拿它去查询 zoxide
    let zoxide_dirs = if (
        $input == "" or (
            not ($input starts-with "./")
            and not ($input starts-with "../")
            and not ($input starts-with "~")
        )
    ) {
        ^zoxide query --list --exclude $env.PWD -- $input
        | lines
    } else {
        []
    }

    {
        options: {
            sort: false
            completion_algorithm: fuzzy
            case_sensitive: false
        }
        completions: (
            $local_dirs
            | append $zoxide_dirs
            | uniq
        )
    }
}

def --wrapped --env cd [...args: string@cd-completer] {
    z ...$args
}
